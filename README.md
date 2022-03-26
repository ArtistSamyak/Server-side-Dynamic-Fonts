# Server-side-Dynamic-Fonts
This projects shows how we can server-side add/update "ANY" custom font in a live iOS App without needing to update the app.

# Inspiration
We see in Web Development, How easy it is to update fonts in our website by just pasting a link from Google Fonts. I've tried to replicate the same effect but in an iOS App.

# Advantage
By this method, we can update the fonts of our live iOS apps unto any font without the need to updare the app by the users!

# Steps to use
1. Use a fixed API endpoint to recieve a link to download any new font file (fileFormat: .tff). Here, I've used GitHub to host my fixed endpoint json https://artistsamyak.github.io/CSS-MySite/CustomFont.json
2. Use the FileDownloader.swift class do download the new font file from recieved URL and save into FileManager. Here, I'm searching for a font to add on Google Fonts and looking for it's URL in "AllGoogleFonts.doc". I took these from Google Fonts Developer API.
3. From the font file path, call the "getFont" method to register the new font and return it.
4. apply the font changes into UI Elements whereever required.

