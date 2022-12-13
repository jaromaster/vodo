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

    println(args[1])

    return true
}

// print help
fn print_help() {
    println("SYNTAX: vodo [CMD] [VALUE]")
}

fn main() {
    // get args
    args := os.args.clone()


    // all valid commands
    mut valid_cmds := map[string]bool
    valid_cmds["add"] = true
    valid_cmds["del"] = true
    valid_cmds["help"] = true


    valid := check_input(args, valid_cmds)

    if valid == false {
        print_help()
        exit(1)
    }
}