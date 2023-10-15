AniRoll (iOS)
=============
AniRoll is an [Anilist project](https://anilist.co) implementation for iOS using [Analist API](http://anilist-api.readthedocs.io/) to display the serie's data and any related data available.

## Copyright
* Copyright (C) 2023 Lech H. Conde - Open Source Matters. All rights reserved.
* Distributed under the GNU General Public License version 3 or later. Read [License details](LICENSE.md) or see <https://www.gnu.org/licenses/>.

## Project Generation
We're using [Tuist](https://docs.tuist.io/tutorial/get-started) command line tool to facilitate the project's generation.
To install tuist run the following command in your terminal:
```
curl -Ls https://install.tuist.io | bash
```
To generate the project you just have to run the following command from the project root directory:
```
tuist generate
```

## Anilist Features
* Custom Lists: Create your own personal list to further categorize your anime & manga
* 6+ Scoring systems: Score with either 10-point, decimal, 5-star, or any other of our scoring systems.
* Join the community!: With forums, live chat and personal messages you'll always be able to find other anime and manga fans to chat with.
* Manhua & Manhwa: As well as anime & manga you can also find all your favourite manhua & manhwa from sites like Webtoons an Lezhin.
* Tag Search: Finding the perfect 'Cute Girls Doing Cute Things' show is just a few clicks away.
* Coming Soon: Achievements, Blogs, even more Statistics/Graphs, and lots of other improvements are coming soon.

## Bonus Features
* User and profile connection (plus favorite series)
* Multiple collection views at home table view
* Reachability
* Use offline persistence (CoreData or Realm)
* Filtering (look at series/browse section)
* Play youtube’s video in a modal view (you can use the SDK)
* Character’s complete info
* Display mangas information too! If you add this, make sure you add the scope bar to the
search.

## Sections
* My AniRoll
* Anime
* Manga
* Social

### Register Form
* username
* email
* password
* repeat password

### Login Form
* email
* password

### Browse Anime
Use the following filters to browse anime:
- Year
- Season
- Status
- Type
- Sort
- Genres
- Tags

## Screenshots
Launch Screen | Login
-- | --
![aniroll-launchscreen](https://github.com/zyrx/AniRoll/assets/1212083/5081b6c9-c078-45f4-956b-3495f3b098d4) | ![aniroll-login](https://github.com/zyrx/AniRoll/assets/1212083/7022a416-be97-43b3-a768-4fee53780530)
