import strconv
import os


// execute the command and return message
pub fn execute_cmd(args []string, vodo_dir_path string, vodo_csv_path string) ?string {
	message := "successful"
	cmd := args[1]


	// check if vodo folder / csv file exist (if needed for command)
	special_cmds := ["help", "init", "reset"]
	if cmd !in special_cmds {
		check_vodo_inited(vodo_csv_path) or {
			return err
		}
	}


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

		task_desc := args[2].trim_space()
		until := args[3].trim_space()

		add_task(vodo_csv_path, task_desc, until) or {
			return err
		}
	}
	// list command
	else if cmd == "list" {

		tasks := get_tasks(vodo_csv_path) or {
			return err
		}

		sorted_tasks := sort_by_until(tasks) or {
			return err
		}

		println("todos")
		println("id\tdescription${"":-20}\tuntil")
		print_tasks(sorted_tasks)
	}
	// delete command
	else if cmd == "del" {

		task_id := strconv.atoi(args[2]) or {
			return err
		}
		delete_task(task_id, vodo_csv_path) or {
			return err
		}
	}
	// search command
	else if cmd == "search" {

		search := args[2]
		tasks := search_tasks(search, vodo_csv_path) or {
			return err
		}

		if tasks.len > 0 {
			print_tasks(tasks)
		} else {
			println("no results for '" + search + "'")
		}
	}


    return message
}


// check if vodo csv file exist
fn check_vodo_inited(vodo_csv_path string) ?{

	err_msg := "could not find vodo folder. please run 'vodo init' first"
	if os.is_file(vodo_csv_path) == false {
		return error(err_msg)
	}
}