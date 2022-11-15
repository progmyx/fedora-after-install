#!/bin/bash
#Configure DNF for Faster Downloads of Packages
sudo sh -c "echo 'fastestmirror=true' >> /etc/dnf/dnf.conf"
sudo sh -c "echo 'deltarpm=true' >> /etc/dnf/dnf.conf"
sudo sh -c "echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf"
sudo dnf -y upgrade --refresh
#Enable RPM Fusion Repository
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y fedora-workstation-repositories
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf config-manager -y --set-enabled google-chrome
sudo dnf config-manager -y --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
sudo dnf group upgrade -y --with-optional Multimedia
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y sound-and-video
sudo dnf groupinstall -y "C Development Tools and Libraries" "Development Tools"
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel lame\* --exclude=lame-devel gstreamer1-plugin-openh264 mozilla-openh264 unzip p7zip p7zip-plugins unrar grub-customizer google-chrome-stable switchdesk switchdesk-gui fira-code-fonts 'mozilla-fira*' 'google-roboto*' alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686 libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686  cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 libedit.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686  sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686 libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686 libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64 winehq-staging zsh telegram-desktop sqlite

#Install Fedy
sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y
#
sudo sed -i 's/^Exec=\/usr\/bin\/google-chrome-stable$/& --enable-features=WebUIDarkMode --force-dark-mode/' /usr/share/applications/google-chrome.desktop
sudo sed -i 's/^Exec=\/usr\/bin\/google-chrome-stable %U$/& --enable-features=WebUIDarkMode --force-dark-mode/' /usr/share/applications/google-chrome.desktop
#
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#Installing winetricks
wget -P ~/Загрузки  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
sudo cp ~/Загрузки/winetricks /usr/local/bin
#To download and install the (separate) BASH completion script for winetricks:
wget -P ~/Загрузки https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks.bash-completion
sudo cp ~/Загрузки/winetricks.bash-completion /usr/share/bash-completion/completions/winetricks   # Standard location for BASH completion scripts (Arch, Gentoo, OpenSUSE, Fedora, Debian/Ubuntu, Solus)

echo "Имя компьютера:"
read hostname
sudo hostnamectl set-hostname "$hostname"
