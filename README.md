# Redfield Deathmatch

**A feature-rich multiplayer deathmatch gamemode for Multi Theft Auto: San Andreas (MTA:SA).**

Redfield Deathmatch is a PvP-focused gamemode for **Multi Theft Auto: San Andreas**, featuring multiple competitive arenas, customizable player lobbies and persistent character progression.

The gamemode combines team-based combat, Free-for-All battles, an in-game economy, achievements, unlockable skins, lootboxes and VIP features into a competitive multiplayer experience.

---

## ✨ Features

### ⚔️ Tactics Arena

Tactics Arena is a team-based PvP mode in which **Angels of Death** and **Yakuza** compete against each other across multiple maps.

- Automatic team distribution
- Round-based gameplay
- Automatic map rotation
- Individual kill, death and damage tracking
- Performance-based rewards
- Spectator system
- MVP tracking
- VIP-based map selection

### 🔫 Deagle Arena

Deagle Arena is a **Free-for-All mode** focused exclusively on Desert Eagle combat.

Players can create and customize their own lobbies with the following options:

- Custom lobby names
- Adjustable player limits
- Password-protected lobbies
- Custom welcome messages
- Map selection
- Additional VIP lobby features

### 💥 Deathmatch Arena

Deathmatch Arena offers classic **Free-for-All combat** with multiple weapons and customizable player lobbies.

- Desert Eagle, MP5, M4 and Rifle
- Custom lobby creation
- Adjustable lobby settings
- Multiple playable maps
- VIP-exclusive lobby options

### 👤 Accounts & Player Progression

- Account registration and login
- Persistent MySQL player data
- Player money and GDM Coins
- Playtime tracking
- Kill, death and damage statistics
- Individual arena progression
- Unlocked character skins
- VIP status management
- MVP statistics

### 💰 Economy & Coins

- Money rewards for kills and damage
- Tactics match rewards
- Payday system
- Minigame rewards
- GDM Coins premium currency
- Weapon shop

### 📦 Lootboxes & Skins

- Unlockable GTA:SA character skins
- Multiple rarity levels, from Common to Mythic
- Permanent skin unlocks
- Skin selection system
- Lootbox rewards
- Free lootbox distribution under certain conditions

### 💎 VIP System

Redfield Deathmatch features three VIP ranks, each offering additional gameplay benefits and customization options.

- Bronze VIP
- Silver VIP
- Gold VIP

Depending on the VIP rank, players can receive:

- Increased lobby player limits
- Persistent lobby settings
- Additional playable maps
- Improved gameplay rewards
- Shop discounts
- Tactics map selection

### 🏆 Achievements & Statistics

- Persistent achievement system
- Progression milestones
- Arena-specific statistics
- Kill, death and damage tracking
- Playtime statistics
- Player leaderboards

### 🎮 Additional Gameplay Systems

- Random chat minigames
- Custom damage and hit handling
- Spectator functionality
- Tutorial and help system

### 🛡️ Administration

- Administration system
- Server management functionality

### 🖥️ User Interface

- Custom HUD
- Scoreboard
- Custom nametags
- Notifications and infoboxes
- Custom chat system
- German and English language support

---

## ⚙️ Installation

### Requirements

- Multi Theft Auto: San Andreas server
- MySQL database

### Setup

**1. Download the repository**

Clone the repository or download the source code.

**2. Install the resource**

Place the gamemode inside your MTA server's `resources` directory.

```text
resources/
└── RedfieldDeathmatch/
```

**3. Set up the database**

Create a MySQL database and import or create the required database tables.

**4. Configure the database connection**

Open the following file:

```text
RegisterLogin/sRegisterLogin.lua
```

Update the database connection settings to match your server environment.

**5. Start the resource**

Start the gamemode using your MTA server console.

```text
start RedfieldDeathmatch
```

**6. Verify the installation**

Check the server console for errors and ensure that the database connection and required systems are functioning correctly.

---

## 🎬 Media

- **[Watch Gameplay on YouTube](https://youtu.be/w5DOkOPpvhg)**

### Screenshots

A collection of screenshots showcasing the gamemode's arenas, interfaces and gameplay features.

<p align="center">
  <img src="Screenshots/1.png" width="350">
  <img src="Screenshots/2.png" width="350">
  <img src="Screenshots/3.png" width="350">
  <img src="Screenshots/4.png" width="350">
  <img src="Screenshots/5.png" width="350">
  <img src="Screenshots/6.png" width="350">
</p>

<details>
<summary><b>View More Screenshots</b></summary>

<p align="center">
  <img src="Screenshots/7.png" width="350">
  <img src="Screenshots/8.png" width="350">
  <img src="Screenshots/9.png" width="350">
  <img src="Screenshots/10.png" width="350">
  <img src="Screenshots/11.png" width="350">
  <img src="Screenshots/12.png" width="350">
  <img src="Screenshots/13.png" width="350">
  <img src="Screenshots/14.png" width="350">
  <img src="Screenshots/15.png" width="350">
  <img src="Screenshots/16.png" width="350">
  <img src="Screenshots/17.png" width="350">
  <img src="Screenshots/18.png" width="350">
  <img src="Screenshots/19.png" width="350">
  <img src="Screenshots/20.png" width="350">
  <img src="Screenshots/21.png" width="350">
</p>

</details>

---

## 📊 Project Statistics

| Metric | Count |
|---|---:|
| Lua Files | 40 |
| Additional Files | 363 |
| Functions | 313 |
| Lines | 5,583 |
| Characters | 266,772 |
| Comment Lines | 367 |
| Comment Characters | 5,027 |
