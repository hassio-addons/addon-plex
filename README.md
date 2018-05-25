# Community Hass.io Add-ons: Plex

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

[![GitLab CI][gitlabci-shield]][gitlabci]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]

[![Bountysource][bountysource-shield]][bountysource]
[![Discord][discord-shield]][discord]
[![Community Forum][forum-shield]][forum]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

Your recorded media, live TV, online news, and podcasts, beautifully organized
and ready to stream.

## About

The plex add-on brings your favorite media together in one place, making it
beautiful and easy to enjoy. The Plex Media Server provided by this addon,
organizes your personal video, music, and photo collections
and streams them to all of your devices.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add our Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "Plex" add-on.
1. Surf to <https://www.plex.tv/claim> and get your claim token.
1. Update the add-on config with the claim code you've got in the previous step.
1. Save the add-on configuration.
1. Start the "Plex" add-on.
1. Check the logs of the "Plex" add-on to see if everything went well.
1. Login the the Plex admin interface and complete the setup process.

**NOTE**: Do not add this repository to Hass.io, please use:
`https://github.com/hassio-addons/repository`.

**NOTE**: When adding media locations, please use `/shares` as the base
directory.

## Docker status

[![Docker Architecture][amd64-arch-shield]][amd64-dockerhub]
[![Docker Version][amd64-version-shield]][amd64-microbadger]
[![Docker Layers][amd64-layers-shield]][amd64-microbadger]
[![Docker Pulls][amd64-pulls-shield]][amd64-dockerhub]

[![Docker Architecture][i386-arch-shield]][i386-dockerhub]
[![Docker Version][i386-version-shield]][i386-microbadger]
[![Docker Layers][i386-layers-shield]][i386-microbadger]
[![Docker Pulls][i386-pulls-shield]][i386-dockerhub]

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```json
{
  "log_level": "info"
}
```

**Note**: _This is just an example, don't copy and past it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The Home Assistant [Community Forum][forum], we have a
  [dedicated topic][forum] on that forum regarding this add-on.
- The Home Assistant [Discord Chat Server][discord] for general Home Assistant
  discussions and questions.
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We have set up a separate document containing our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## We have got some Hass.io add-ons for you

Want some more functionality to your Hass.io Home Assistant instance?

We have created multiple add-ons for Hass.io. For a full list, check out
our [GitHub Repository][repository].

## License

MIT License

Copyright (c) 2018 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-anchore-shield]: https://anchore.io/service/badges/image/67d1185473090e99d5ac5e1bb4d1aa2295117a9bd3d7abbf8cd8a71e331c8388
[aarch64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fplex-aarch64%3Alatest
[aarch64-arch-shield]: https://img.shields.io/badge/architecture-aarch64-blue.svg
[aarch64-dockerhub]: https://hub.docker.com/r/hassioaddons/plex-aarch64
[aarch64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/plex-aarch64.svg
[aarch64-microbadger]: https://microbadger.com/images/hassioaddons/plex-aarch64
[aarch64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/plex-aarch64.svg
[aarch64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/plex-aarch64.svg
[amd64-anchore-shield]: https://anchore.io/service/badges/image/031c3ec49491c191e22395ba19981eaaabb892802c6698af08c92bfc8319cdc0
[amd64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fplex-amd64%3Alatest
[amd64-arch-shield]: https://img.shields.io/badge/architecture-amd64-blue.svg
[amd64-dockerhub]: https://hub.docker.com/r/hassioaddons/plex-amd64
[amd64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/plex-amd64.svg
[amd64-microbadger]: https://microbadger.com/images/hassioaddons/plex-amd64
[amd64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/plex-amd64.svg
[amd64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/plex-amd64.svg
[armhf-anchore-shield]: https://anchore.io/service/badges/image/da56ee1d91a6b46756fcbf9d1bf2e90860a37ea992b57fa4627a8394b5fd239c
[armhf-anchore]: https://anchore.io/image/dockerhub/hassioaddons%plex-armhf%3Alatest
[armhf-arch-shield]: https://img.shields.io/badge/architecture-armhf-blue.svg
[armhf-dockerhub]: https://hub.docker.com/r/hassioaddons/plex-armhf
[armhf-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/plex-armhf.svg
[armhf-microbadger]: https://microbadger.com/images/hassioaddons/plex-armhf
[armhf-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/plex-armhf.svg
[armhf-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/plex-armhf.svg
[bountysource-shield]: https://img.shields.io/bountysource/team/hassio-addons/activity.svg
[bountysource]: https://www.bountysource.com/teams/hassio-addons/issues
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee]: https://www.buymeacoffee.com/frenck
[commits-shield]: https://img.shields.io/github/commit-activity/y/hassio-addons/addon-plex.svg
[commits]: https://github.com/hassio-addons/addon-plex/commits/master
[contributors]: https://github.com/hassio-addons/addon-plex/graphs/contributors
[discord-shield]: https://img.shields.io/discord/330944238910963714.svg
[discord]: https://discord.gg/c5DvZ4e
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/t/community-hass-io-add-on-plex/36742?u=frenck
[frenck]: https://github.com/frenck
[gitlabci-shield]: https://gitlab.com/hassio-addons/addon-plex/badges/master/pipeline.svg
[gitlabci]: https://gitlab.com/hassio-addons/addon-plex/pipelines
[home-assistant]: https://home-assistant.io
[i386-anchore-shield]: https://anchore.io/service/badges/image/4b740c5341d0c0aa373563eaf98f3b98655859ee2d5f4e1b226e7976162c9961
[i386-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fplex-i386%3Alatest
[i386-arch-shield]: https://img.shields.io/badge/architecture-i386-blue.svg
[i386-dockerhub]: https://hub.docker.com/r/hassioaddons/plex-i386
[i386-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/plex-i386.svg
[i386-microbadger]: https://microbadger.com/images/hassioaddons/plex-i386
[i386-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/plex-i386.svg
[i386-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/plex-i386.svg
[issue]: https://github.com/hassio-addons/addon-plex/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-plex.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2018.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/hassio-addons/addon-plex.svg
[releases]: https://github.com/hassio-addons/addon-plex/releases
[repository]: https://github.com/hassio-addons/repository
[semver]: http://semver.org/spec/v2.0.0.htm
