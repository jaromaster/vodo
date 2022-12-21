import os

// check if cmd args/flags valid
fn check_input(args []string, valid_cmds map[string]bool) bool {

    if args.len < 2 {
        return false
    }

    cmd := args[1]
    if valid_cmds[cmd] == false {
        return false
    }

    return true
}


fn main() {
    // get args
    args := os.args.clone()


    // all valid commands
    mut valid_cmds := map[string]bool
    valid_cmds["add"] = true
    valid_cmds["del"] = true
    valid_cmds["help"] = true
    valid_cmds["init"] = true
    valid_cmds["reset"] = true
    valid_cmds["list"] = true


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