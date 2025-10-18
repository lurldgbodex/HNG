function updateTime() {
  const timeElement = document.querySelector('[data-testid="test-user-time"]');
  const lastUpdatedElement = document.getElementById("last-updated");

  if (timeElement) {
    timeElement.textContent = Date.now();
  }

  if (lastUpdatedElement) {
    const now = new Date();
    lastUpdatedElement.textContent = now.toLocaleString();
  }
}

updateTime();
setInterval(updateTime, 1000);
