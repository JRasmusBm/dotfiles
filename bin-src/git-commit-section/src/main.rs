use std::process::{exit, Command};

fn main() {
    let Ok(output) = Command::new("git").args(["local-main-branch"]).output() else {
        exit(1)
    };

    let commit_range = format!("{}..HEAD", String::from_utf8_lossy(&output.stdout));
    let Ok(output) = Command::new("git").args(["--no-pager", "log", "--reverse", "--format=%b", &commit_range]).output() else {
        exit(1)
    };

    println!("{:?}", String::from_utf8_lossy(&output.stdout));
}
