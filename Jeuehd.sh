#! / bin / bash
clear
echo
echo "################################################# ################# "
echo "# Google BBRv2 x86_64 Install"
echo "# Author: LALA <QQ1062951199>"
echo "# Website: https://www.lala.im"
echo "# System Required: CentOS 7 or Debian 8/9 or Ubuntu 19.04 x86_64"
echo "################################################# ################# "
echo

system_check () {
	if [-f / usr / bin / yum]; then
		centos_install
	elif [-f / usr / bin / apt]; then
		debian_install
	else
		echo -e "你 的 系统 不 支持"
	me
}

centos_install () {
	yum -y install git
	git clone https://github.com/xiya233/bbr2.git
	cd bbr2 / centos
	yum -y localinstall *
	grub2-set-default 0
	echo "tcp_bbr" >> /etc/modules-load.d/tcp_bbr.conf
	echo "tcp_bbr2" >> /etc/modules-load.d/tcp_bbr2.conf
	echo "tcp_dctcp" >> /etc/modules-load.d/tcp_dctcp.conf
	sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_ecn/d' /etc/sysctl.conf
	echo "net.ipv4.tcp_congestion_control = bbr2" >> /etc/sysctl.conf
	echo "net.ipv4.tcp_ecn = 1" >> /etc/sysctl.conf
	sysctl -p
	rm -rf ~ / bbr2
	read -p "内核 安装 完成 ， 重启 生效 ， 是否 现在 重启？ [Y / n]:" at
	[-z "$ {in}"] && yn = "y"
	if [[$ yn == [Yy]]]; then
		echo -e "正在 重启"
		reboot
	me
}

debian_install () {
	apt -y update
	apt -y install git
	git clone https://github.com/xiya233/bbr2.git
	cd bbr2 / debian
	apt -y install *
	echo "tcp_bbr" >> / etc / modules
	echo "tcp_bbr2" >> / etc / modules
	echo "tcp_dctcp" >> / etc / modules
	sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_ecn/d' /etc/sysctl.conf
	echo "net.ipv4.tcp_congestion_control = bbr2" >> /etc/sysctl.conf
	echo "net.ipv4.tcp_ecn = 1" >> /etc/sysctl.conf
	sysctl -p
	rm -rf ~ / bbr2
	read -p "内核 安装 完成 ， 重启 生效 ， 是否 现在 重启？ [Y / n]:" at
	[-z "$ {in}"] && yn = "y"
	if [[$ yn == [Yy]]]; then
		echo -e "正在 重启"
		reboot
	me
}

start_menu () {
	read -p "请 输入 数字 (1/2/3) 1 ： 安装 BBRv2 2 ： 开启 ECN 3 ： 我 是 咸鱼 我 退出:" num
	case "$ num" in
		1)
		system_check
		;;
		2)
		echo 1> / sys / module / tcp_bbr2 / parameters / ecn_enable
		;;
		3)
		exit 1
		;;
	esac
}

start_menu
