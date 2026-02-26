## Using the repository
- Import the key
    - `cat /path/to/pgp-key.asc | sudo tee /etc/apt/trusted.gpg.d/limas.asc`
- Add the repository
    - `sudo add-apt-repository -S deb https://raw.githubusercontent.com/MunckhofFruit/LimasV2-Releases/main/apt-repo noble main`
- Add the rosdep listing
    - `echo "yaml https://raw.githubusercontent.com/MunckhofFruit/LimasV2-Releases/main/rosdep/limas.yml" | sudo tee /etc/ros/rosdep/sources.list.d/30-limas.list`

## Adding new packages
- Copy files to the correct directory (`apt-repo/pool/main/noble/`)
- Run the `update-repo.sh` script from this directory