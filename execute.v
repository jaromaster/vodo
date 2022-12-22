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

		task_desc := args[2]
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

		task_id := strconv.atoi(args[2]) or {
			return err
		}
		delete_task(task_id, vodo_csv_path) or {
			return err
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