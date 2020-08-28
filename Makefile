all: launch

# Initial setup
autoinstall:
	truncate -s 10G vm.img
	docker run -it --rm -p 3003:80 -v $(CURDIR):/srv --name caddy caddy caddy file-server
	sudo kvm -no-reboot -m 1024 -drive file=vm.img,format=raw,cache=none,if=virtio -cdrom ./ubuntu-20.04.1-live-server-amd64.iso -kernel /mnt/casper/vmlinuz -initrd /mnt/casper/initrd -append 'autoinstall ds=nocloud-net;s=http://_gateway:3003/'

launch:
	sudo kvm -no-reboot -m 1024 -drive file=vm.img,format=raw,cache=none,if=virtio
