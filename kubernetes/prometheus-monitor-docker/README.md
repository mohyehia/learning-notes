### Load Testing
- `dd if=/dev/zero of=testfile_16GB bs=1M count=16384; openssl speed -multi $(nproc --all) &`

### Stop Load Testing
- `rm testfile_16GB && kill $(pgrep openssl)`