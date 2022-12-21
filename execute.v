import strconv


// execute the command and return message
pub fn execute_cmd(args []string, vodo_dir_path string, vodo_csv_path string) ?string {
	message := "successful"
	cmd := args[1]


	// init command
	if cmd == "init" {
		println("initializing vodo...")

		init_cmd(vodo_dir_path, vodo_csv_path) or {
			return err
		}
	}
	// help command
	else if cmd == "help" {
		print_help()
	}
	// reset command
	else if cmd == "reset" {
		println("resetting vodo...")

		reset_cmd(vodo_dir_path) or {
			return err
		}
	}
	// add command
	else if cmd == "add" {

		if args.len != 3 {
			return error("invalid number of arguments. please use 'vodo help' to print the help")
		}

		task_desc := args[2]
		println("adding '" + task_desc + "' to tasks...")

		add_task(vodo_csv_path, task_desc) or {
			return err
		}
	}
	// list command
	else if cmd == "list" {

		tasks := get_tasks(vodo_csv_path) or {
			return err
		}

		print_tasks(tasks)
	}
	// delete command
	else if cmd == "del" {

		if args.len != 3 {
			return error("invalid number of arguments. please use 'vodo help' to print the help")
		}

		task_id := strconv.atoi(args[2]) or {
			return err
		}

		delete_task(task_id, vodo_csv_path) or {
			return err
		}
	}


    return message
}


