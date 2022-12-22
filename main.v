import os

// check if cmd args/flags valid
fn check_input(args []string, valid_cmds map[string]int) bool {

    if args.len < 2 {
        return false
    }

    cmd := args[1]
    if valid_cmds[cmd] == 0 || args.len != valid_cmds[cmd] {
        return false
    }

    return true
}


fn main() {
    // get args
    args := os.args.clone()


    // all valid commands with number of args
    mut valid_cmds := map[string]int
    valid_cmds["add"] = 4
    valid_cmds["del"] = 3
    valid_cmds["search"] = 3
    valid_cmds["help"] = 2
    valid_cmds["init"] = 2
    valid_cmds["reset"] = 2
    valid_cmds["list"] = 2


    // path to .vodo.csv
    vodo_dir_path := os.home_dir() + "/.vodo"
    vodo_csv_path := vodo_dir_path + "/.vodo.csv"


    // check args
    valid := check_input(args, valid_cmds)
    if valid == false {
        print_help()
        exit(1)
    }

    // execute command
    execute_cmd(args, vodo_dir_path, vodo_csv_path) or {
        println(err)
        exit(1)
    }
}