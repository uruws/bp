# Buildpack pgrades schedule

* 2309 [M2](https://github.com/TalkingPts/Buildpack/milestone/2)
* 2305-1 [PR5](https://github.com/TalkingPts/Buildpack/pull/5)
* 2305 [PR3](https://github.com/TalkingPts/Buildpack/pull/3)
* 2203 [Changelog](../compare/81af1d8b7c139a0...b6f62a5f2aa686b)

---

* docker/base
    * `2309`: Debian 12.1 (bookworm-20230919-slim)
        * ./docker/base/build.sh: base-2309
    * 2305-2: Debian 12.0 (bookworm-20230703-slim)
    * 2305-1 DSA 5417-1: openssl security update
    * 2305: Debian 11.7 (bullseye-20230502-slim)
    * 2211: Debian 11.5 (bullseye-20221205-slim)
    * 2203-1: Debian 11.3 (bullseye-20220328-slim)
    * 2203: Debian 11.2 (bullseye-20220316-slim)
    * 2109: Debian 10 (buster) -> 11 (bullseye)

---

    $ make upgrades-check
    $ make upgrades
    $ make upgrades-check

---

    $ git tag -a -m 'bpX release' bpX
    $ ./deploy.sh
