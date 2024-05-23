.PHONY: all fs kernel user clean run

all: fs kernel user

fs:
	$(MAKE) -C

kernel:
	$(MAKE) -C

user:
	$(MAKE) -C

run: 
	$(MAKE) -C kernel run
clean:
	$(MAKE) -C fs clean
	$(MAKE) -C kernel clean
	$(MAKE) -C user clean
