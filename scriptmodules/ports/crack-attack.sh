#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="crack-attack"
rp_module_desc="Crack-Attack - Tetris Attack clone"
rp_module_section="exp"
rp_module_flags="!mali !x86"
 
function depends_crack-attack() {
    getDepends cmake xorg
}

function sources_crack-attack() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        gitPullOrClone "$md_build/glshim" https://github.com/ptitseb/glshim.git
    fi
}
 
function build_crack-attack() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        cd "$md_build/glshim"
        cmake . -DBCMHOST=1
        make GL
    fi
}

function install_bin_crack-attack() {
    aptInstall crack-attack
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
       mkdir -p /opt/retropie/supplementary/glshim/
       cp "$md_build/glshim/lib/libGL.so.1" /opt/retropie/supplementary/glshim/
    fi
}
 
function configure_crack-attack() {
    mkdir "ports"
    moveConfigDir "$home/.crack-attack" "$md_conf_root/crack-attack"
    addPort "$md_id" "crack-attack" "Crack-Attack - Tetris Attack clone" "LD_LIBRARY_PATH=/opt/retropie/supplementary/glshim LIBGL_FB=1 xinit crack-attack"
}
