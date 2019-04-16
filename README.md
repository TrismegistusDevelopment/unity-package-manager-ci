# unity-package-manager-ci

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
