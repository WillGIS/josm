###########################################################################
# A module with functions to handle paths
#
# Copyright (C) 2017 Andrey Ponomarenko's ABI Laboratory
#
# Written by Andrey Ponomarenko
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License or the GNU Lesser
# General Public License as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# and the GNU Lesser General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.
###########################################################################
use strict;
use Cwd qw(realpath);

sub pathFmt(@)
{
    my $Path = shift(@_);
    my $Fmt = $In::Opt{"OS"};
    if(@_) {
        $Fmt = shift(@_);
    }
    
    $Path=~s/[\/\\]+\.?\Z//g;
    if($Fmt eq "windows")
    {
        $Path=~s/\//\\/g;
        $Path = lc($Path);
    }
    else {
        $Path=~s/\\/\//g;
    }
    
    $Path=~s/[\/\\]+\Z//g;
    
    return $Path;
}

sub getAbsPath($)
{ # abs_path() should NOT be called for absolute inputs
  # because it can change them
    my $Path = $_[0];
    if(not isAbsPath($Path)) {
        $Path = abs_path($Path);
    }
    return pathFmt($Path, $In::Opt{"OS"});
}

sub realpath_F($)
{
    my $Path = $_[0];
    return pathFmt(realpath($Path));
}

sub join_P($$)
{
    my $S = "/";
    if($In::Opt{"OS"} eq "windows") {
        $S = "\\";
    }
    return join($S, @_);
}

sub join_A($$)
{
    my $S = ":";
    if($In::Opt{"OS"} eq "windows") {
        $S = ";";
    }
    return join($S, @_);
}

return 1;
