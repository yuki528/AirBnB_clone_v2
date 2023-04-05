#!/usr/bin/python3
<<<<<<< HEAD
"""Create and distributes an archive to web servers"""
import os.path
import time
from fabric.api import local
from fabric.operations import env, put, run

env.hosts = ['100.26.252.93', '100.27.11.183']


def do_pack():
    """Generate an tgz archive from web_static folder"""
    try:
        local("mkdir -p versions")
        local("tar -cvzf versions/web_static_{}.tgz web_static/".
              format(time.strftime("%Y%m%d%H%M%S")))
        return ("versions/web_static_{}.tgz".format(time.
                                                    strftime("%Y%m%d%H%M%S")))
=======
""" Function that deploys """
from datetime import datetime
from fabric.api import *
import os
import shlex


env.hosts = ['35.231.33.237', '34.74.155.163']
env.user = "ubuntu"


def deploy():
    """ DEPLOYS """
    try:
        archive_path = do_pack()
    except:
        return False

    return do_deploy(archive_path)


def do_pack():
    try:
        if not os.path.exists("versions"):
            local('mkdir versions')
        t = datetime.now()
        f = "%Y%m%d%H%M%S"
        archive_path = 'versions/web_static_{}.tgz'.format(t.strftime(f))
        local('tar -cvzf {} web_static'.format(archive_path))
        return archive_path
>>>>>>> 9964e2e4593d82ac4324f2ead1a726498d045fa6
    except:
        return None


def do_deploy(archive_path):
<<<<<<< HEAD
    """Distribute an archive to web servers"""
    if (os.path.isfile(archive_path) is False):
        return False

    try:
        file = archive_path.split("/")[-1]
        folder = ("/data/web_static/releases/" + file.split(".")[0])
        put(archive_path, "/tmp/")
        run("mkdir -p {}".format(folder))
        run("tar -xzf /tmp/{} -C {}".format(file, folder))
        run("rm /tmp/{}".format(file))
        run("mv {}/web_static/* {}/".format(folder, folder))
        run("rm -rf {}/web_static".format(folder))
        run('rm -rf /data/web_static/current')
        run("ln -s {} /data/web_static/current".format(folder))
        print("Deployment done")
        return True
    except:
        return False


def deploy():
    """Create and distributes an archive to web servers"""
    try:
        path = do_pack()
        return do_deploy(path)
    except:
        return False

=======
    """ Deploys """
    if not os.path.exists(archive_path):
        return False
    try:
        name = archive_path.replace('/', ' ')
        name = shlex.split(name)
        name = name[-1]

        wname = name.replace('.', ' ')
        wname = shlex.split(wname)
        wname = wname[0]

        releases_path = "/data/web_static/releases/{}/".format(wname)
        tmp_path = "/tmp/{}".format(name)

        put(archive_path, "/tmp/")
        run("mkdir -p {}".format(releases_path))
        run("tar -xzf {} -C {}".format(tmp_path, releases_path))
        run("rm {}".format(tmp_path))
        run("mv {}web_static/* {}".format(releases_path, releases_path))
        run("rm -rf {}web_static".format(releases_path))
        run("rm -rf /data/web_static/current")
        run("ln -s {} /data/web_static/current".format(releases_path))
        print("New version deployed!")
        return True
    except:
        return False
>>>>>>> 9964e2e4593d82ac4324f2ead1a726498d045fa6
