import os


// init (create new dir and csv file for persisting tasks)
pub fn init_cmd(vodo_dir_path string, vodo_csv_path string) ?{

	create_dir(vodo_dir_path) or {
		return err
	}

	create_csv_file(vodo_dir_path, vodo_csv_path) or {
		return err
	}
}


// create new directory if not exists
fn create_dir(vodo_dir_path string) ? {
	if os.is_dir(vodo_dir_path) == false {
		os.mkdir(vodo_dir_path) or {
			return err
		}
	}
}


// create new csv file for storing all tasks if not exists
fn create_csv_file(vodo_dir_path string, vodo_csv_path string) ?{
	csv_header := "id,task"

	if os.is_file(vodo_csv_path) {
		return error("file already exists, please reset first!")
	}

	mut file := os.create(vodo_csv_path) or {
		return err
	}

	file.writeln(csv_header) or {
		return err
	}
}
