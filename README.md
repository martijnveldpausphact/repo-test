## Using the repository
- Import the key
    - `cat /path/to/pgp-key.asc | sudo tee /etc/apt/trusted.gpg.d/myrepo.asc`
- Add the repository
    - `sudo add-apt-repository -S deb https://raw.githubusercontent.com/martijnveldpausphact/repo-test/main/apt-repo noble main`

## Adding new packages

- Copy files to the correct directory (`apt-repo/pool/main/noble/`)
- Update the `Packages` file
    ```sh
    pushd apt-repo
    dpkg-scanpackages --arch amd64 pool/ > dists/noble/main/binary-amd64/Packages
    cat dists/noble/main/binary-amd64/Packages | gzip -9 > dists/noble/main/binary-amd64/Packages.gz
    popd
    ```
- Update the Release file
    - `./generate-release.sh > apt-repo/dists/noble/Release`
- Sign the Release
    - Import the key (if not imported already) 
        - `cat ~/path/to/pgp-key.private | gpg --import`
    - Sign the Release file
        - `cat apt-repo/dists/noble/Release | gpg --default-key Limas -abs > apt-repo/dists/noble/Release.gpg`
    - Sign the InRelease file
        - `cat apt-repo/dists/noble/Release | gpg --default-key Limas -abs --clearsign > apt-repo/dists/noble/InRelease`
