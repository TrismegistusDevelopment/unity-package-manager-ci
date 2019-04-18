# unity-package-manager-ci
[![](https://img.shields.io/badge/Unity-Package%20Manager-blue.svg?logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAQAAADZc7J%2FAAADzElEQVRIx5WVW2jWZRzHP%2B%2F736mdmG6Sp5sUt5ygYpJriad5oGXmhVkXWZCGFWSgtjnacp0QTGKGw3QXoUQw7CIstAhiCrpceGGC5lzpPM2F5DZ1B9veTxf%2BffduKtbvd%2FMc%2BH%2Be5%2F87fB%2F47xYhhRxmUUUDbbwfXzfBY0PGsYRVciKmmOMsq2ywzXzJF0h6yKEBaTzFbBblFM9iHvOZQAaPEKGI5iKaH3IDMgIzXOhmj3jNHvsdtHqp92G%2FQM1GL5loA%2FFRm1GJPgBAGpmk8fYU%2B%2BIfdHne7%2FwtPu92qky9L4C5aWaa5mhPqR222Ohu1zjaHA%2BrGlP7LTeQIAImBE2iG%2BZuW0YmtykgiyaO8yunf%2BEkTcl1tbwO%2FMAAi0mmgVJ60ofdgPXzbQkvucc82c4rTBZh%2BTK7VJ3mYrvUaxZK4RAAG0o8GwarUvZQFN%2FJzfVHVfeZ5eN2qjctk7IEAGULw9P7fM9Acgezwqa1ql50hixIs0Ud8KAcjAOoXOq5MEQVRmVkQlYmTrRV1UoDCairc0C9IBdCAB8872VVb7vRVMmJDWYlPd1tqjY6XsYLpaXeVm%2FIjSSAyIfLquoYBVxkE19%2FzjGeid5NzAAZBbwBxPiSS2u9BBw6xE1GEECQxGORN1e8u5M8AE5whRXrUhJSO0A6b5EB7GMv7AXwVuTbQ8tL2QW7YOtWO%2BL11ecNu%2B1J8G57VG2xWOYO5muDDY6Q%2FCSWLCE7fl4SKQ%2Foy3aa4c%2F4tLOTy%2FTCxSR2Fu%2Bs4TWigJzkOGOH1GaMVJ4km2LWU3khEhgDYOZMlvIs37wDMIO6HWGrHjVfDnIgwb%2FnpzWq%2FuHTskBiEI16Rm2VVkCYwo7PjKl6yplSNqS8R47053gVkhWD6dP9R%2B2W7rt1MInaT0PEOWfLuiGIF%2BbZrfb7orwcg82bHVDbpX2wEidQ%2B3GIOO0cWZ8AyMz0C1WPmCd5HDumapM0JfbCOGqrQ8056xwpT0BMm%2BTvqlYYOM5OtdcaqRnajY8GVoaI874kW1hEVrhXXq7qVcdaZJfaYYmUDNeD3BTLbPWq121zi4vMkv1UU8KoUR5VtcqP7FFPmi3ZwwBCVrIFFjrZIv%2B2zRPut9oSs6X%2BCU%2BrnXYYs9%2FtJknSPQAhmQIKmcwnq8Og9vmXzdb7aigqqr0uvqvLPsAJAg8MEfWb9oRI7TBd0u9R5WGI5zJc5W7PeCtB4O%2FYYTl8n4flHkQGq9gdMd%2FVfuVZr9sbAiqk4j8AQkyE%2FMBUx7jSWhu9YrvFUiz%2FxwJSGcNKamnkCu1U31n%2BF80M7hBuo8ZPAAAAAElFTkSuQmCC&style=popout)](https://docs.unity3d.com/Manual/upm-dependencies.html)
[![](https://img.shields.io/badge/CI-Travis-blue.svg?logo=travis&style=popout)](https://travis-ci.org/)

Travis Ci scripts to push changes to specific branch for using with Unity Package Manager (UPM) system

## How Unity Package Manager works with git


There's `Packages/manifest.json` in your Unity project folder. You can [manually add](https://docs.unity3d.com/Manual/upm-dependencies.html) `git` dependencies in it like this
```
"com.company.repo.name": "https://YourGitHost.com/UserName/RepoName.git#BranchName"
```
To update asset through UPM uoy musc delete reference in `lock` section in manifest.

Currently you must follow strict rules if you want to use your asset like this. Most importantly, aux files (manifest, asmdef) _must be in repo root and have `*.meta` files._

This repo will help you set up CI for separate UPM branch

## Configure Travis
1. Register at https://travis-ci.org/ for public or at https://travis-ci.com/ for private repos
2. Open repo settings, go to `Environment Variables`
3. Add variable with exact name `GITHUB_TOKEN` and value from [created token](https://github.com/settings/tokens) with selected scope `repo`

## Add files to repo
1. Create and push empty branches with desired names, I suggest `upm` and `upm-dev` for `master` and `develop` branches accordingly
2. In your default branch create `package.json` near your main folder (but inside `Assets`!) with keywords and category of your choice:
```
{
	"name": "com.company.repo.name",
	"displayName": "Display Name of Your Asset",
	"version": "0.1.1",
	"unity": "2018.3",
	"description": "Short description of your asset",
	"keywords": [
		"unity", "editor"		
	],
	"category": "Instrument"
}
```
3. Create `com.company.repo.name.asmdef` in the same folder:
```
{
	"name": "Display Name of Your Asset"
}
```
4. Open Unity and make sure that `*.meta` files appeared. You now must have 6 items in your dir: 1 folder, 1 .json, 1 .asmdef and 3 .meta
5. Copy `.travis.yml` file and `ci` folder to project's root
6. Edit `.travis.yml`, change env variables - target branches and folder to export. If you want to test this config, add custom test branch to `branches:  only:` section
7. Commit and push changes

## Different info
If your commit doesn't require CI (like readme editing) you can add `[skip ci]` into your commit message and Travis won't build it
