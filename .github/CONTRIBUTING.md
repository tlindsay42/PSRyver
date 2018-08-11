# How to contribute

Contributions to PSRyver would be awesome!  Below are some guidelines to get you started.

## Getting Started

* Make sure you have a [GitHub account](https://github.com/signup/free).
* Submit a new issue, assuming one does not already exist.
    * Clearly describe the issue including steps to reproduce when it is a bug.
    * Make sure you fill in the earliest version that you know has the issue.
* Fork the repository on GitHub.

## Suggesting Enhancements

Is anything missing from PSRyver?  Is there anything that could be done to improve it, including documentation?

Helpful things to include:

* A brief description of what could be changed, and why this might be helpful.
* If possible, a brief mock-up showing how the enhancement would look (e.g. command and output).

## Making Changes

* From your fork of the repository, create a topic branch where work on your change will take place.
* To quickly create a topic branch based on master; `git checkout -b my_contribution master`. Please avoid working directly on the `master` branch.
* Make commits of logical units.
* Check for unnecessary whitespace with `git diff --check` before committing.
* Please follow the prevailing code conventions in the repository. Differences in style make the code harder to understand for everyone.
* Try to follow [commit messages like these](https://chris.beams.io/posts/git-commit/).
* Try to include all the necessary Pester tests for your changes.
* Run _all_ PESTER tests in the module to assure nothing else was accidentally broken (AppVeyor does this automatically, but running locally can save you time).

### PSRyver-specific Contribution Tips

#### Adding a new command

Depending on what command you add, there are a few files you might consider changing:

* Add your command (eg: [`PSRyver\Public\Get-RyverUser.ps1`](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverUser.ps1)).
* Write a private command to parse the output (eg: [`PSRyver\Private\Format-RyverUserObject.ps1`](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverUserObject.ps1)).
* Add your function and file names to [`PSRyver\PSRyver.psd1`](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/PSRyver.psd1).

## Documentation

* Chances are the documentation is out of date, and missing important bits - pull requests welcome!

## Submitting Changes

* Push your changes to a topic branch in your fork of the repository (eg: `git push origin my_contribution`)
* Submit a pull request to the main repository.
* Once the pull request has been reviewed and accepted, it will be merged with the master branch.
* Celebrate!

## Additional Resources

* [General GitHub documentation](https://help.github.com/).
* [GitHub forking documentation](https://guides.github.com/activities/forking/).
* [GitHub pull request documentation](https://help.github.com/send-pull-requests/).
* [GitHub Flow guide](https://guides.github.com/introduction/flow/).
* [GitHub's guide to contributing to open source projects](https://guides.github.com/activities/contributing-to-open-source/).

Thanks for Brandon Olin for [most of this guide](https://github.com/poshbotio/PoshBot/blob/master/.github/CONTRIBUTING.md)!
