let currentVersion = null;

async function loadVersionInfo() {
  try {
    const res = await fetch("https://krshbalaji.github.io/pkc_app/version.json?" + new Date().getTime());
    const data = await res.json();

    currentVersion = data.version;

    document.getElementById("version").innerText = `📦 Version ${data.version}`;
    document.getElementById("downloadLink").href = data.apk_url;
    document.getElementById("changelog").innerText = data.changelog;

    new QRCode(document.getElementById("qrcode"), {
      text: data.apk_url,
      width: 160,
      height: 160
    });

  } catch (err) {
    document.getElementById("version").innerText = "⚠️ Failed to load version info.";
    console.error("Failed to load version.json:", err);
  }
}

async function checkForUpdate() {
  try {
    const response = await fetch("https://krshbalaji.github.io/pkc_app/version.json?" + new Date().getTime());
    const data = await response.json();

    if (currentVersion && data.version !== currentVersion) {
      alert(`🚀 New version ${data.version} available! Refreshing...`);
      location.reload();
    }
  } catch (error) {
    console.warn("Update check failed:", error);
  }
}

loadVersionInfo();
setInterval(checkForUpdate, 60000); // check every 60 seconds
