
// execute the command and return message
pub fn execute_cmd(args []string, vodo_dir_path string, vodo_csv_path string) ?string {
	message := "successful"

	cmd := args[1]


	// init command
	if cmd == "init" {
		println("running vodo init...")

		init_cmd(vodo_dir_path, vodo_csv_path) or {
			return err
		}
		return message
	}


    return message
}


