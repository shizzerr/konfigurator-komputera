#Algorytm dobieraj¹cy najlepsz¹ konfiguracjê komputera, do kwoty jak¹ podaje u¿ytownik

#install.packages("GA")
#install.packages("dplyr")
library(GA)
library(dplyr)

#U¿ytkownik wprowadza kwotê, któr¹ mo¿e przeznaczyæ na komputer oraz do czego ma byæ przeznaczony
cat("Konfigurator komputera v0.1 by Pawe³ Piwkowski & Micha³ Doliñski\n
    Wska¿ bud¿et przeznaczony na komputer jako liczbê ca³kowit¹,\n
    nastêpnie wska¿ do jakiego celu przeznaczony bêdzie komputer\n
    poprzez wpisane cyfry odpowiadaj¹cej danemu wariantowi.\n
    1. Komputer do gier,\n
    2. Komputer do biura,\n
    3. Komputer do tworzenia grafiki komputerowej,\n
    4. Komputer do u¿ytku domowego,\n
    5. Komputer do programowania")

#uzytkownikKwota <- sample(3000:10000,1)
uzytkownikKwota <- as.integer(readline(prompt = "Podaj bud¿et: "))
#wyborUzytkownika <- sample(1:5,1)
wyborUzytkownika <- as.integer(readline(prompt = "Ktora opcje komputera wybierasz: "))


#Definiujemy zbiory danych zawieraj¹ce sprzêt komputerowy
if(uzytkownikKwota > 0 && wyborUzytkownika > 0 && wyborUzytkownika < 6){
plytaGlowna = data.frame(
	przedmiot = c("Asus Z390-H","ASRock B365M-HDV", "Biostar A68N", "MSI B450M Pro-VDH", "MSI B350M GamingPlus",
	              "Gigabyte MX31-BS0", "MSI X470", "Gigabyte B450 Aorus pro", "ASRock Fatal1ty x470", "Asus Prime Z390-P"),
	wartosc = c(200, 200, 300, 500, 800, 340, 250, 300, 580, 700),
	rekomendacja = c(5, 5, 4, 3, 4, 3, 2, 1, 2, 1),
	indeks = c(1,1,1,1,1,1,1,1,1,1)
)
procesor = data.frame(
  przedmiot = c("AMD Ryzen 5 2400G", "AMD Ryzen 2600","Intel Core i5 9400F", "AMD Ryzen 5 3600", "AMD Ryzen 3600X", 
                "Intel Core i5 9600K", "AMD Ryzen 7 3700X", "Intel Core i7 9700K", "AMD Ryzen 9 3900X", "Intel Core i9 9900K"),
  wartosc = c(550, 550, 670, 830, 1000, 1030, 1500, 1800, 2300, 2290),
  rekomendacja = c(4, 2, 2, 5, 4, 5, 3, 1, 3, 1),
  indeks = c(2,2,2,2,2,2,2,2,2,2)
)
pamiecRAM = data.frame(
  przedmiot = c("Corsair Vengeance LPX 32GB", "G.Skill Trident 16GB","G.Skill Trident Z 64GB", "Team Group Z 64GB", "Crucial Ballistix 16GB", 
                "HyperX Predator 16GB", "PNY Anarchy 16GB", "ADATA XPX Z1 16GB", "Patriot Viper Elite 8GB", "G.Skill Ripijaws V 16GB"),
  wartosc = c(800, 450, 1200, 900, 500, 420, 600, 380, 300, 280),
  rekomendacja = c(3, 5, 1, 2, 5, 4, 1, 3, 4, 2),
  indeks = c(3,3,3,3,3,3,3,3,3,3)
)
dyskTwardy = data.frame(
  przedmiot = c("Segate Barracuda", "Toshiba X300","WD VelociRaptor", "WD Blue Desktop", "Segate Firecuda Desktop", "Segate IronWolf NAS", 
                "WD MyBook", "G-Technology G-Drive", "Segate FireCuda Mobile", "WD Red"),
  wartosc = c(80, 50, 200, 120, 100, 70, 100, 250, 300, 280),
  rekomendacja = c(4, 5, 4, 2, 5, 2, 1, 3, 3, 1),
  indeks = c(4,4,4,4,4,4,4,4,4,4)
)
obudowa = data.frame(
  przedmiot = c("SilentiumPC Ragnum RG4", "SilentiumPC Armis AR5 TG","Cooler Master MasterBox Q500L", "SilentiumPC Armis AR3 TR RGB", "be quiet! Pure Base 600", 
                "Phanteks Enthoo Pro", "be quiet! Silent Base 601 Window", "be quiet! Silent Base 801", "Fractal Design Meshify S2 TG", "Fractal Design Define S2"),
  wartosc = c(100, 400, 200, 40, 500, 70, 100, 250, 300, 280),
  rekomendacja = c(1, 4, 5, 2, 3, 2, 1, 3, 5, 4),
  indeks = c(5,5,5,5,5,5,5,5,5,5)
)
kartaGraficzna = data.frame(
  przedmiot = c("MSI Radeon RX 570 Armor 4G OC", "MSI Radeon RX 580 Armor 8G OC","Asus Dual GeForce GTX 1660 Ti OC 6GB", "Palit GeForce RTX 2060 GamingPro OC",
                "MSI Radeon RX 5700 MECH OC", "Gigabyte GeForce RTX 2060 SUPER Gaming OC 8G", "Gigabyte Radeon RX 5700 XT Gaming OC 8G",
                "ASUS Dual GeForce RTX 2070 SUPER EVO OC", "MSI GeForce RTX 2080 SUPER Ventus OC", "Gigabyte GeForce RTX 2080 Ti Gaming OC 11G"),
  wartosc = c(700, 1000, 1400, 1700, 1800, 1950, 1990, 2750, 3400, 5590),
  rekomendacja = c(2, 2, 5, 4, 5, 4, 1, 3, 1, 3),
  indeks = c(6,6,6,6,6,6,6,6,6,6)
)
zasilacz = data.frame(
  przedmiot = c("SilverStone Strider Titanum 700W", "Enermax 500W","EVGA SuperNOVA g3 650W", "Fortron 300W","EuroCase ATX-500W", "Thermaltake Toughpower GF1 850W",
                "LC-Power Metraton Gaming 750W", "SilverStone Strider 600W", "EVGA Supernova 850GQ", "SilentiumPC Supremo m2 550w"),
  wartosc = c(800, 200, 515, 260, 270, 570, 370, 242, 604, 333),
  rekomendacja = c(1, 4, 2, 2, 5, 4, 3, 3, 1, 5),
  indeks = c(7,7,7,7,7,7,7,7,7,7)
)
monitor = data.frame(
  przedmiot = c("Acer V7", "Asus VA279HAE", "LG 75XS2C", "Hannsoree Hanns.G HL225HPB", "iiyama T2236MSC-B2", "Acer ED323QURAbidpx",
                "Asus MG279Q", "Elo Touch Solutions ET1991L", "Faytech FT133TMBCAP", "AOC 24P1"),
  wartosc = c(600, 660, 6900, 440, 1460, 1394, 2150, 2800, 1900, 650),
  rekomendacja = c(2, 4, 3, 2, 5, 5, 1, 1, 3, 4),
  indeks = c(8,8,8,8,8,8,8,8,8,8)
)
klawiatura = data.frame(
  przedmiot = c("Savio Tempest RX Green", "A4 Tech BLOODY B930","Marvo KG925G", "E-Blue Mazer Black US", "Logitech G213 Prodigy", 
                "Modecom Volcano Hammer RGB Outem Brown", "REDRAGON K578RGB", "Corsair K70 RGB Mk.2 Rapidfire Low Profile", "Natec NKG0873", "iBox Aurora K-4"),
  wartosc = c(120, 221, 225, 140, 200, 188, 208, 709, 62, 180),
  rekomendacja = c(4, 3, 3, 2, 5, 4, 1, 5, 1, 2),
  indeks = c(9,9,9,9,9,9,9,9,9,9)
)
myszka = data.frame(
  przedmiot = c("A4 Tech EVO XGame Laser Oscar X747", "Gambias Erebos Optical","Natec Krypton 800 Black", "SteelSeries Rival 650",
                "Genesis Xenon 750", "Cougar 700 EVO", "Asus ROG Pugio 90MP00L0-B0UA0",
                "Mysz A4 Tech V-Track XGame F5", "Riotoro Aurox RGB White", "Corsair Harpoon RGB"),
  wartosc = c(121, 219, 167, 504, 132, 367, 280, 110, 188, 237),
  rekomendacja = c(2, 5, 4, 1, 3, 1, 3, 2, 4, 5),
  indeks = c(10,10,10,10,10,10,10,10,10,10)
)


#Tworzymy kolejn¹ bazê danych zawieraj¹c¹ sprzêt dobrany do wyboru u¿ytkownika
if(wyborUzytkownika == 1){
  pg=filter(plytaGlowna,rekomendacja == 1)
  pr=filter(procesor,rekomendacja == 1)
  pram=filter(pamiecRAM,rekomendacja == 1)
  dt=filter(dyskTwardy,rekomendacja == 1)
  ob=filter(obudowa,rekomendacja == 1)
  kg=filter(kartaGraficzna,rekomendacja == 1)
  zas=filter(zasilacz,rekomendacja == 1)
  mon=filter(monitor,rekomendacja == 1)
  my=filter(myszka,rekomendacja == 1)
  kl=filter(klawiatura,rekomendacja == 1)
  
  komputer <- Reduce(function(x,y)merge(x,y,all = TRUE),list(pg,pr,pram,dt,ob,kg,zas,mon,kl,my))  
} else if(wyborUzytkownika == 2){
  pg=filter(plytaGlowna,rekomendacja == 2)
  pr=filter(procesor,rekomendacja == 2)
  pram=filter(pamiecRAM,rekomendacja == 2)
  dt=filter(dyskTwardy,rekomendacja == 2)
  ob=filter(obudowa,rekomendacja == 2)
  kg=filter(kartaGraficzna,rekomendacja == 2)
  zas=filter(zasilacz,rekomendacja == 2)
  mon=filter(monitor,rekomendacja == 2)
  my=filter(myszka,rekomendacja == 2)
  kl=filter(klawiatura,rekomendacja == 2)
  
  komputer <- Reduce(function(x,y)merge(x,y,all = TRUE),list(pg,pr,pram,dt,ob,kg,zas,mon,kl,my))  
} else if (wyborUzytkownika == 3){
  pg=filter(plytaGlowna,rekomendacja == 3)
  pr=filter(procesor,rekomendacja == 3)
  pram=filter(pamiecRAM,rekomendacja == 3)
  dt=filter(dyskTwardy,rekomendacja == 3)
  ob=filter(obudowa,rekomendacja == 3)
  kg=filter(kartaGraficzna,rekomendacja == 3)
  zas=filter(zasilacz,rekomendacja == 3)
  mon=filter(monitor,rekomendacja == 3)
  my=filter(myszka,rekomendacja == 3)
  kl=filter(klawiatura,rekomendacja == 3)
  
  komputer <- Reduce(function(x,y)merge(x,y,all = TRUE),list(pg,pr,pram,dt,ob,kg,zas,mon,kl,my))  
} else if (wyborUzytkownika == 4){
  pg=filter(plytaGlowna,rekomendacja == 4)
  pr=filter(procesor,rekomendacja == 4)
  pram=filter(pamiecRAM,rekomendacja == 4)
  dt=filter(dyskTwardy,rekomendacja == 4)
  ob=filter(obudowa,rekomendacja == 4)
  kg=filter(kartaGraficzna,rekomendacja == 4)
  zas=filter(zasilacz,rekomendacja == 4)
  mon=filter(monitor,rekomendacja == 4)
  my=filter(myszka,rekomendacja == 4)
  kl=filter(klawiatura,rekomendacja == 4)
  
  komputer <- Reduce(function(x,y)merge(x,y,all = TRUE),list(pg,pr,pram,dt,ob,kg,zas,mon,kl,my))
  
} else if (wyborUzytkownika == 5){
  pg=filter(plytaGlowna,rekomendacja == 5)
  pr=filter(procesor,rekomendacja == 5)
  pram=filter(pamiecRAM,rekomendacja == 5)
  dt=filter(dyskTwardy,rekomendacja == 5)
  ob=filter(obudowa,rekomendacja == 5)
  kg=filter(kartaGraficzna,rekomendacja == 5)
  zas=filter(zasilacz,rekomendacja == 5)
  mon=filter(monitor,rekomendacja == 5)
  my=filter(myszka,rekomendacja == 5)
  kl=filter(klawiatura,rekomendacja == 5)
  
  komputer <- Reduce(function(x,y)merge(x,y,all = TRUE),list(pg,pr,pram,dt,ob,kg,zas,mon,kl,my))}
rm(pg,pr,pram,dt,ob,kg,zas,mon,my,kl,plytaGlowna,procesor,pamiecRAM,dyskTwardy,obudowa,kartaGraficzna,zasilacz,monitor,myszka,klawiatura)
} else {cat("Wybierz konfiguracjê z przedzia³u od 1 do 5!")}

#Definiujemy funkcjê przystosowania
g = 0
while(g<=50){
i=1
komputerTemp<-matrix(nrow=10,ncol=4)
colnames(komputerTemp)<-c("przedmiot", "wartosc", "rekomendacja", "indeks")
while(i <= 10){
  if (i == 1) {
    r = sample(1:2,1)
    komputerTemp[1,1] = toString(komputer[r,1])
    komputerTemp[1,2] = as.integer(komputer[r,2])
    komputerTemp[1,3] = as.integer(komputer[r,3])
    komputerTemp[1,4] = as.integer(komputer[r,4])
    i = i + 1
    next
  } else if(i == 2) {
    r = sample(3:4,1)
    komputerTemp[2,1] = toString(komputer[r,1])
    komputerTemp[2,2] = as.integer(komputer[r,2])
    komputerTemp[2,3] = as.integer(komputer[r,3])
    komputerTemp[2,4] = as.integer(komputer[r,4])
    i = i + 1
  } else if(i == 3) {
    r = sample(5:6,1)
    komputerTemp[3,1] = toString(komputer[r,1])
    komputerTemp[3,2] = as.integer(komputer[r,2])
    komputerTemp[3,3] = as.integer(komputer[r,3])
    komputerTemp[3,4] = as.integer(komputer[r,4])
    i = i + 1
  } else if(i == 4) {
    r = sample(7:8,1)
    komputerTemp[4,1] = toString(komputer[r,1])
    komputerTemp[4,2] = as.integer(komputer[r,2])
    komputerTemp[4,3] = as.integer(komputer[r,3])
    komputerTemp[4,4] = as.integer(komputer[r,4])
    i = i + 1
  } else if(i == 5) {
    r = sample(9:10,1)
    komputerTemp[5,1] = toString(komputer[r,1])
    komputerTemp[5,2] = as.integer(komputer[r,2])
    komputerTemp[5,3] = as.integer(komputer[r,3])
    komputerTemp[5,4] = as.integer(komputer[r,4])
    i = i + 1
    
  } else if(i == 6) {
    r = sample(11:12,1)
    komputerTemp[6,1] = toString(komputer[r,1])
    komputerTemp[6,2] = as.integer(komputer[r,2])
    komputerTemp[6,3] = as.integer(komputer[r,3])
    komputerTemp[6,4] = as.integer(komputer[r,4])
    i = i + 1
    
  } else if(i == 7) {
    r = sample(13:14,1)
    komputerTemp[7,1] = toString(komputer[r,1])
    komputerTemp[7,2] = as.integer(komputer[r,2])
    komputerTemp[7,3] = as.integer(komputer[r,3])
    komputerTemp[7,4] = as.integer(komputer[r,4])
    i = i + 1
    
  } else if(i == 8) {
    r = sample(15:16,1)
    komputerTemp[8,1] = toString(komputer[r,1])
    komputerTemp[8,2] = as.integer(komputer[r,2])
    komputerTemp[8,3] = as.integer(komputer[r,3])
    komputerTemp[8,4] = as.integer(komputer[r,4])
    i = i + 1
    
  } else if(i == 9) {
    r = sample(17:18,1)
    komputerTemp[9,1] = toString(komputer[r,1])
    komputerTemp[9,2] = as.integer(komputer[r,2])
    komputerTemp[9,3] = as.integer(komputer[r,3])
    komputerTemp[9,4] = as.integer(komputer[r,4])
    i = i + 1
    
  } else if(i == 10) {
    r = sample(19:20,1)
    komputerTemp[10,1] = toString(komputer[r,1])
    komputerTemp[10,2] = as.integer(komputer[r,2])
    komputerTemp[10,3] = as.integer(komputer[r,3])
    komputerTemp[10,4] = as.integer(komputer[r,4])
    i = i + 1
  } else {break}
} 
komputerwartosc = data.frame(wartosc=as.numeric(komputerTemp[,2]))
i=1
fitnessFunc = function(chr) {
  calkowitaWartoscChr = chr %*% komputerwartosc$wartosc
  if (calkowitaWartoscChr > uzytkownikKwota) return(-calkowitaWartoscChr) 
  else return(calkowitaWartoscChr)
  }
#Uruchamiamy algorytm genetyczny dla zadanych parametrów
wyniki=ga(type="binary",nBits=10,fitness=fitnessFunc,popSize=100,pcrossover=0.85,pmutation=0.05,elitism=5,maxiter=200,seed=0,keepBest = TRUE)
g=g+1
}
#Podsumawanie dzia³ania algorytmu genetycznego		   
summary(wyniki)
plot(wyniki)

#Dekodowanie (prezentacja) pojedynczego rozwi¹zania
decode=function(chr){
	print("Konfiguracja: ")
	print(komputerTemp[chr == 1, -3])
	print( paste("Wartoœæ konfiguracji =",chr %*% komputerwartosc$wartosc) )
}
check = sum(c(wyniki@solution))
if(check !=10){
  sprintf("Niestety w kwocie %i nie uda³o siê stworzyæ konfiguracji komputera, proszê podaæ wiêksz¹ kwotê.", uzytkownikKwota)
}else{
  decode(wyniki@solution[1,])
}

