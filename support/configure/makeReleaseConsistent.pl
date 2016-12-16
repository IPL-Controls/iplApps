# FILENAME...	makeReleaseConsistent.pl
#
# SYNOPSIS...	makeReleaseConsistent(supporttop_dir, apptop_dir epics_base_dir,
#				master_release, release_dirs)
#
# USAGE...      Take the version info. from the "master_release" file and
#	rewrite the <supporttop>/configure/RELEASE file macros, giving them
#	absolute pathnames and the correct support module versions.
#
# NOTES...
#	- Master release files MUST have a "_RELEASE" suffix.
#
# MODIFICATION LOG..
#  01/26/04 - Bug fix; no support for master files w/o macros.
#  05/12/06 - Change permissions on updated RELEASE files to include group write
#             write access.
#  08/19/08 - master_config_dir argument changed to one "master_release" file.
#  12/18/12 - script rewrote to remove writing to temp file.
#

#
# Version:	 $Revision: 16494 $
# Modified By:	 $Author: mooney $
# Last Modified: $Date: 2013-05-22 16:27:59 -0500 (Wed, 22 May 2013) $
# HeadURL:       $URL: https://subversion.xray.aps.anl.gov/synApps/configure/tags/synApps_5_7/makeReleaseConsistent.pl $

use strict; # prevent implicit creation of global variables
use warnings;

# local scalar variables
my $supporttop    = shift;
my $apps_top      = shift;
my $epics_base    = shift;
my $master_file   = shift;

# local array variables
my @masterFile;
my @releaseFile;
my @prefix;
# hash varialbes
my %macro;
# scalar variables
my %post;
my $release_file; 
my $line;
my $iter          = 0;
my $tmp1;
my $tmp2;

# Parse MASTER_RELEASE_FILE
open(FILE, "<$master_file") || die "Cannot open master_file $master_file for reading\n";
@masterFile = <FILE>;
close FILE;
foreach $line (@masterFile) {
    if (($line !~ /^(#|\s*\n)/)&&($line =~ /.*\s*=\s*\$\(.*\).*/)) {
        chomp($line);
        $_ = $line;
        ($prefix[$iter], $tmp1, $tmp2) = /(.*)\s*=\s*\$\((.*)\)(.*)/;
        $macro{$prefix[$iter]} = $tmp1;
        $post{$prefix[$iter]}  = $tmp2;
        $iter++;
    }
}
$prefix[$iter] = "EPICS_BASE";
$macro{$prefix[$iter]} = "";
$post{$prefix[$iter]}  = $epics_base;
$iter++;
$prefix[$iter] = "SUPPORT";
$macro{$prefix[$iter]} = "";
$post{$prefix[$iter]}  = $supporttop;
$iter++;
$prefix[$iter] = "IPL_SUPPORT";
$macro{$prefix[$iter]} = "";
$post{$prefix[$iter]}  = $apps_top;
$iter++;


# Rewrite RELEASE_FILES
foreach $release_file (@ARGV) {
    open(FILE, "<$release_file") || die "Cannot open release_file $release_file for reading\n";
    @releaseFile = <FILE>;
    close FILE;
    foreach $line (@releaseFile) {
        for(my $i=0; $i<scalar @prefix; $i++) {
            if ($line =~ /^\s*$prefix[$i]\s*=/) {
                if ($macro{$prefix[$i]} ne "")
                   {$line = $prefix[$i]."=\$(".$macro{$prefix[$i]}.")".$post{$prefix[$i]}."\n";}
                else {$line = $prefix[$i]."=".$post{$prefix[$i]}."\n";}
            }
        }
    }
    open(FILE, ">$release_file") || die "Cannot open release_file $release_file for writing\n";
    foreach $line (@releaseFile) {print FILE $line;}
    close FILE;
    chmod 0664, $release_file;
}
