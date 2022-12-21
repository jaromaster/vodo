import os

// reset vodo by deleting the vodo folder
fn reset_cmd(vodo_dir_path string) ?{

	os.rmdir_all(vodo_dir_path) or {
		return error("could not remove .vodo folder (maybe run 'vodo init' to create it)")
	}
}