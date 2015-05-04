#include <mtd/mtd-user.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <unistd.h>

#ifndef MTD_PART
#define MTD_PART            "/dev/mtd2"
#endif

#define BLOCK_START         0x110000
#define BLOCK_SIZE          0x10000


int main(int argc, char** argv){
	struct erase_info_user erase;
	unsigned long value;
	int fd;

	if(argc != 2){
		fprintf(stderr,"Usage: write-magic value\n");
		return 1;
	}

	value = strtoul(argv[1],NULL,0);

	if( (fd = open(MTD_PART,O_RDWR)) == -1){
		perror("Failed to open device");
		return 1;
	}

	erase.start = BLOCK_START;
	erase.length = BLOCK_SIZE;
	if (ioctl (fd, MEMERASE, &erase) != 0) {
		perror("Erase block failed");
		return 1;
	}

	if(lseek(fd, BLOCK_START, SEEK_SET) == -1) {
		perror("Failed to seek to block");
		return 1;
	}
	if( write(fd,&value,sizeof(value)) != sizeof(value)){
		perror("Failed to write value");
		return 1;
	}

	close(fd);

	return 0;
}
