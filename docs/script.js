async function loadVersionInfo() {
  try {
    const res = await fetch("https://krshbalaji.github.io/pkc_app/version.json");
    const data = await res.json();

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
  }
}

loadVersionInfo();
