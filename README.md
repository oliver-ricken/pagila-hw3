# pagila-hw3
[![](https://github.com/oliver-ricken/pagila-hw3/workflows/tests/badge.svg)](https://github.com/oliver-ricken/pagila-hw3/actions?query=workflow%3Atests)

## Tasks

1. Fork this repo and clone it on to the lambda server like normal.
    Ensure that you properly get the `pagila` submodule data.

1. Build the containers and enter psql with the following commands.
    ```
    $ docker-compose up -d --build
    $ docker-compose exec pg psql
    ```

1. We will now observe some problems with the pagila dataset,
    and upgrade the dataset to fix these problems.

    Count the number of staff members and stores in this dataset.
    ```
    postgres=# select count(*) from store;
     count
    -------
         2
    (1 row)
    ```
    ```
    postgres=# select count(*) from staff;
     count
    -------
         2
    (1 row)
    ```
    Obvserve that this data is not very realistic.
    In the realworld, every store would need more than 1 staff member.
    Also, since the dataset has customers from many different countries,
    it should probably have stores in many different countries as well.

    Fortunately, the pagila maintainers have also realized this problem and updated the dataset. 
    But since the dataset is version controled as a git submodule,
    we don't yet have access to this new data.
    And this is a good thing!
    If git automatically gave us access to the new data when it was released,
    then our test cases could break.

    Run the following commands.
    ```
    $ cd pagila/
    $ git log -n1
    commit 726c724df9f86406577c47790d6f8e6f2be06186 (HEAD)
    Merge: 2f097fb dd799b9
    Author: Devrim Gündüz <devrim@gunduz.org>
    Date:   Fri Feb 5 20:22:04 2021 +0000

        Merge pull request #14 from zOxta/patch-1

        Add missing user argument
    ```
    Observe that the data you are currently using is from 2021.
    (The commit hash `726c724d` is the same commit you've been using for the previous pagila assignments.)

    We will now upgrade our data to the latest commit.
    Run the commands
    ```
    $ git checkout master
    $ git log -n1
    commit e1e5a855c46176bc0e17b7e8dea2f61e555fb378 (HEAD -> master, origin/master, origin/HEAD)
    Merge: fef9675 93126fa
    Author: Devrim Gündüz <devrim@gunduz.org>
    Date:   Mon Jan 22 14:15:57 2024 +0000

        Merge pull request #30 from mgramin/master

        More diverse data #28
    ```
    Observe that you now have very recent data from January 2024.

    To get access to this data, you will need to bring down your docker containers, and rebuild the images.
    You can verify that you have access to the new data by recounting the number of stores and staff members.
    ```
    postgres=# select count(*) from store;
     count
    -------
       500
    (1 row)
    ```
    ```
    postgres=# select count(*) from staff;
     count
    -------
      1500
    (1 row)
    ```

    > **NOTE:**
    > Reproducability is very important for debugging large industrial code bases.
    > It is therefore standard practice in industry to version control test databases like this.
    > A common complaint from industry about newly graduated data science students is that they don't know how to version control data.
    > One of the purposes of this assignment is to familiarize you with this concept.


1. Complete the test cases in the same way that you did for the [pagila-hw](https://github.com/mikeizbicki/pagila-hw) assignment.

    > **NOTE:**
    > When you upload to github,
    > you will have to ensure that github actions is aware of the new pagila dataset.
