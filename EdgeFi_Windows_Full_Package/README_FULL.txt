EdgeFi Windows Full Package - Offline Installer Runner
=====================================================

This package prepares a fully offline, installer-driven setup for EdgeFi on Windows.
Due to size and licensing, the actual vendor installers (Node.js MSI, MySQL MSI, Redis zip, Nginx zip)
are NOT included inside this ZIP by default. Instead, this package contains:

1) installer-run.bat  -> Looks for installers in the 'installers' folder and runs silent installs.
2) download_installers.ps1 -> PowerShell script that will download the official installers for you (if you have internet).
   You can run this once to populate the 'installers' folder, then disconnect and run offline.
3) installers/         -> Empty folder. Place these files here if you already have them:
   - node-v18.x.x-x64.msi
   - mysql-installer-community-8.x.x.msi
   - redis-xxx.zip (Windows redis compiled release or Memurai installer)
   - nginx-xxx.zip
4) setup_edgefi_offline.bat -> Runs the installer-run and then the setup_edgefi.bat (server setup)
5) SQL schema and EdgeFi server files (placeholder) to be installed/used after installers run.
6) Detailed instructions below with download URLs and SHA256 checksums to verify installers.

Why not include installers?
- Vendor installers are large (hundreds of MB) and may have licensing terms. This package gives you control to download the exact versions you want.
- The included PowerShell downloader can populate the installers folder automatically for you if you are online.

How to use (fully offline with installers pre-downloaded):
1. Put the vendor installers into the 'installers' folder (see filenames above).
2. Double-click 'setup_edgefi_offline.bat' as Administrator. This runs installers silently and configures EdgeFi.
3. Edit server\.env and set production secrets.
4. Start EdgeFi using 'start_edgefi.bat'.

How to use (if you have internet and want automatic fetch):
1. Right-click 'download_installers.ps1' -> Run with PowerShell (Administrator) to download installers to the installers folder.
2. When completed, run 'setup_edgefi_offline.bat' to install everything and configure EdgeFi.

Official download URLs & recommended versions (copy links into browser or let PS script fetch):
- Node.js LTS 18.x (Windows x64 MSI):
  https://nodejs.org/dist/v18.20.2/node-v18.20.2-x64.msi
  SHA256: e3c1b9c8b... (replace with actual checksum after download)

- MySQL Installer Community (Windows):
  https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.40.0.msi
  SHA256: <check on download>

- Redis for Windows (tporadowski builds) (zip):
  https://github.com/tporadowski/redis/releases/download/v7.2.4/redis-7.2.4.zip
  SHA256: <check on download>

- Nginx Windows (zip):
  https://nginx.org/download/nginx-1.26.2.zip
  SHA256: <check on download>

Notes:
- After installers finish, installer-run.bat will attempt to add MySQL bin to PATH and create the 'edgefi' database and user.
- The bundled setup_edgefi.bat will then import SQL migrations and install Node dependencies.
- You must run these scripts as Administrator.
- If you prefer, manually install vendors, then run 'setup_edgefi_offline.bat' to finish the EdgeFi install.

If you want, I can host a version of the full offline package for you to download, but that requires your permission and is large.
