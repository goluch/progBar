package pl.treecmp.progressbar.logic;

public class Task {

    private int total;
    private int progress;
    private String status;

    public Task() {
        this.status = "created";

        total = 100;
    }

    public void execute() throws InterruptedException {

        status = "executing";

        int i = 0;

        while (i < total && status.equals("executing")) {

            progress = (100 * (i + 1) / total);
            Thread.sleep(1000);
            i++;
        }
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
