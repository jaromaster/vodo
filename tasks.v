import os
import strconv

// Task struct
struct Task {
	id int [required]
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

	old_tasks := get_tasks(vodo_csv_path) or {
		return err
	}

	mut csv_file := os.open_append(vodo_csv_path) or {
		return error("could not add task to vodo file. please run 'vodo init' first")
	}
	defer {csv_file.close()}

	// get next id
	mut max_id := 0
	for t in old_tasks {
		max_id = t.id
	}

	task := Task{id: max_id+1, description: task_desc}

	csv_file.writeln(task.to_csv()) or {
		return error("could not write to vodo file. please run 'vodo init' first")
	}
}


// get all tasks as lists of strings (each row of csv file separated by comma)
fn get_tasks(vodo_csv_path string) ?[]Task {
	separator := ","

	lines := os.read_lines(vodo_csv_path) or {
		return error("could not read vodo file. please run 'vodo init' first")
	}
	
	mut tasks := []Task{}
	for i in 1..lines.len { // skip header => 1..end
		task_arr := lines[i].split(separator)
		id := strconv.atoi(task_arr[0]) or {
			return err
		}
		description := task_arr[1]
		task := Task{id: id, description: description}

		tasks << task
	}

	return tasks
}


// print the tasks as a list
fn print_tasks(tasks []Task) {
	list_style := "-" // style of list items

	for task in tasks {
		output := "${list_style} (id: ${task.id})\t${task.description}" // display task

		println(output)
	}
}


// TODO delete task

// TODO search/filter tasks