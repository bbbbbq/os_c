typedef struct {
  void (*read_block)(BlockCache *b);
  void (*write_block)(BlockCache *b);
} BlockDevice;