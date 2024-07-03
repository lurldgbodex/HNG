document.addEventListener("DOMContentLoaded", function () {
  function updateTimeAndDay() {
    const now = new Date();
    document.getElementById("currentTimeUTC").textContent = now.toUTCString();
    document.getElementById("currentDay").textContent = now.toLocaleString(
      "en-US",
      { weekday: "long" }
    );
  }
  updateTimeAndDay();
  setInterval(updateTimeAndDay, 60000); // Update every minute
});
