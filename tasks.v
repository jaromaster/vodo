import os
import rand

// Task struct
struct Task {
	id string [required]
	description string [required]
}

// convert task to csv row (for persisting)
fn (t Task) to_csv() string {

	s := "${t.id},${t.description}"
	return s
}


// add new task to tasks
fn add_task(vodo_csv_path string, task_desc string) ? {

	if os.is_file(vodo_csv_path) == false {
		return error("could not find vodo folder / file. please run 'vodo init' first")
	}

	mut csv_file := os.open_append(vodo_csv_path) or {
		return error("could not add task to vodo file. please run 'vodo init' first")
	}
	defer {csv_file.close()}

	task := Task{id: rand.uuid_v4(), description: task_desc}

	csv_file.writeln(task.to_csv()) or {
		return error("could not write to vodo file. please run 'vodo init' first")
	}
}

// TODO delete task

// TODO get all tasks

// TODO search/filter tasks