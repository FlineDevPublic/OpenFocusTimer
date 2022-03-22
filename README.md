# OpenFocusTimer

Pomodoro timer with categories, reflection, history & statistics. Developed fully in the open while [streaming live on Twitch](https://www.twitch.tv/Jeehut), full recordings available [here on YouTube](https://www.youtube.com/playlist?list=PLvkAveYAfY4TVdM3Lc52SJTkuGB85I5uw).

## About

You can find a description of this projects features [here](https://www.notion.so/flinedev-public/Open-Focus-Timer-59d9331cd3c84c13be7aa38beb6bc277).

## Getting Started

This project is modularized into many small Swift packages using Point-Free's [modularization approach](https://www.pointfree.co/episodes/ep171-modularization-part-1). To work on it, open the `OpenFocusTimer/OpenFocusTimer.xcodeproj` file (not the `Package.swift` file at the root). Choose the scheme `iOSApp` or `macOSApp` to run the full app.

The advantage of the modularization is that you can also choose any of the other targets such as `TimerFeature` to only build a smaller package for faster build times when working only on that part of the project.

This app applies Point-Free's [The Composable Architecture (TCA)](https://www.pointfree.co/collections/composable-architecture/a-tour-of-the-composable-architecture). For TCA newcomers, it consists of a `View` with a related `State` struct and `Action` enum which are combined in the so called `Store` object. All navigation, state updating and side-effects logic is put into a `Reducer`, which has access to an `Environment` to make the whole feature easily testable.

## Donation

OpenFocusTimer was brought to you by [Cihat Gündüz](https://github.com/Jeehut) while [streaming live on Twitch](https://twitch.tv/Jeehut). If you want to thank me and support the development of this project, please **make a small donation on [PayPal](https://paypal.me/Dschee/5EUR)**. In case you also like my other [open source contributions](https://github.com/Flinesoft) and [articles](https://medium.com/@Jeehut), please consider motivating me by **becoming a sponsor on [GitHub](https://github.com/sponsors/Jeehut)** or a **patron on [Patreon](https://www.patreon.com/Jeehut)**.

Thank you very much for any donation, it really helps out a lot! 💯


## Contributing

Contributions are welcome. Feel free to open an issue on GitHub with your ideas or implement an idea yourself and post a pull request. If you want to contribute code, please try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).

## License
This project is released under the [GNU General Public License, version 3 (GPL-3.0)](http://opensource.org/licenses/GPL-3.0).

