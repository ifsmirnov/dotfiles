#!/usr/bin/python3

from subprocess import Popen, PIPE
import argparse
import yaml
import tabulate

DB_PATH = "/home/ifsmirnov/.session_cb.yaml"

def load_db():
    try:
        with open(DB_PATH) as f:
            res = yaml.safe_load(f)
            if res is None:
                res = {}
            return res
    except FileNotFoundError:
        return {}

def store_db(db):
    with open(DB_PATH, "w") as f:
        yaml.dump(db, f)

def store():
    db = load_db()
    print("Enter key:")
    key = input()
    print("Enter value:")
    value = input()
    db[key] = value
    store_db(db)

def select():
    db = load_db()
    tabulate.PRESERVE_WHITESPACE = True
    table = tabulate.tabulate(([k, "\t" + v] for k, v in db.items()), tablefmt="plain")

    p = Popen(
        ["/usr/bin/fzf", "--tac", "--expect=tab"],
        stdin=PIPE, stdout=PIPE)
    stdout = p.communicate(input=table.encode())[0].decode()
    lines = stdout.splitlines()
    if len(lines) != 2:
        print("Something went wrong")
        return

    value = lines[1].split("\t", maxsplit=1)[1]
    cmd = lines[0].strip()
    if cmd == "tab":
        p = Popen(["xclip", "-i", "-sel", "clip"], stdin=PIPE)
        p.communicate(input=value.encode())
    else:
        p = Popen(["tmux", "send-keys", value.encode()])
        p.communicate()
    #  print("Value:", value)

def main():
    parser = argparse.ArgumentParser()
    g = parser.add_mutually_exclusive_group(required=True)
    g.add_argument("--store", action="store_true")
    g.add_argument("--select", action="store_true")

    args = parser.parse_args()

    if args.store:
        store()
    else:
        select()

if __name__ == "__main__":
    main()
