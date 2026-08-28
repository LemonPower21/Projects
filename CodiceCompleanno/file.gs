// Funzione principale che controlla le date e invia l'email
function controllaCompleanni() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  const data = sheet.getDataRange().getDisplayValues(); // Legge le celle esattamente come testo "GG/MM/AAAA"
  
  const oggi = new Date();
  const giornoOggi = oggi.getDate(); //28
  const meseOggi = oggi.getMonth() + 1; // getMonth() restituisce 0-11, aggiungiamo 1 per avere 1-12 //08
  const annoOggi = oggi.getFullYear(); //2026

  let festeggiati = [];

  // Ciclo che parte dalla riga 1 per saltare le intestazioni (ID, Nome, Data)
  for (let i = 1; i < data.length; i++) {
    const nome = data[i][1] ? data[i][1].trim() : ""; // Colonna B: Nome
    const dataStr = data[i][2] ? data[i][2].trim() : ""; // Colonna C: Data

    if (!nome || !dataStr) continue;

    // Converte la stringa GG/MM/AAAA  GG=0 MM=1 AAAA=2
    const partiData = dataStr.split("/");
    if (partiData.length === 3) {
      const giornoNascita = parseInt(partiData[0], 10);
      const meseNascita = parseInt(partiData[1], 10);
      const annoNascita = parseInt(partiData[2], 10);

      // Verifica se oggi è il giorno di compleanno
      if (giornoNascita === giornoOggi && meseNascita === meseOggi) {
        const eta = annoOggi - annoNascita;
        festeggiati.push({ nome: nome, eta: eta });
      }
    }
  }

  let oggetto = "";
  let messaggio = "";

  if (festeggiati.length > 0) {
    oggetto = "🎉 Today Birthdays";
    messaggio = "🎉 TODAY BIRTHDAYS! 🎉\n\n";
    festeggiati.forEach(f => {
      messaggio += `🎂 ${f.nome} turns ${f.eta} today!\n`;
    });
  } else {
    oggetto = "📅 No Birthdays Today";
    messaggio = "There aren't birthdays today!";
  }

  // Prende l'email del proprietario/esecutore dello script (compatibile con i trigger automatici)
  const emailDestinatario = Session.getEffectiveUser().getEmail();

  // Invio diretto dell'email
  try {
    MailApp.sendEmail(emailDestinatario, oggetto, messaggio);
    Logger.log("Email sent successfully! " + emailDestinatario);
  } catch (e) {
    Logger.log("Sending mail error: " + e.message);
  }
}
