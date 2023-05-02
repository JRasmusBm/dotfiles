use std::process::Command;

fn main() {
    let commits = Command::new("git").outpt()

    println!(commits);
git --no-pager log --reverse --format="%b" "$(git local-main-branch)..HEAD"
}
