Baza danych pozwala na uporządkowanie informacji związanych ze zwierzętami. Została stworzona z myślą o wykorzystaniu w **schroniskach dla bezdomnych zwierząt**. Po modyfikacji tabel mogłaby także zostać wykorzystana np. w hotelach dla pupili czy innych **placówkach pracujących ze zwierzętami**.

Baza przechowuje szczegółowe dane na temat <ins>zwierząt</ins>, <ins>wizyt weterynaryjnych</ins>, <ins>diagnoz</ins>. Przechowuje dane <ins>osób, które zaadoptowały zwierzęta</ins>, odnotowywane są także informacje na temat <ins>wizyt poadopcyjnych</ins>. Znajdują się w niej również informacje o <ins>pracownikach</ins> i <ins>stanowiskach</ins>, jakie zajmują (np. właściciel, pracownik administracyjny, weterynarz) oraz <ins>wolontariuszach</ins>. 

W bazie nie są osobno przechowywane informacje o tym, w jaki sposób zwierzęta zostały przyjęte do schroniska. W razie konieczności dane te mogą być umieszczone w kolumnie "informacje" w tabeli "zwierzę".
*	W schronisku przyjmowane są różne gatunki zwierząt domowych.
*	Nie wszystkie zwierzęta zostały zaadoptowane. Jedno zwierzę może zostać zaadoptowane kilkukrotnie.
*	Pracownik może być zatrudniony tylko na jednym stanowisku.
*	Zarobki pracownika są uzależnione od stanowiska, na jakim jest zatrudniony.
*	Zwierzę musi mieć co najmniej jedną wizytę weterynaryjną, może mieć ich wiele.
*	W trakcie wizyty weterynaryjnej musi zawsze zostać postawiona diagnoza. Tabela „diagnoza” w kolumnie „nazwa” będzie zawierała wiersz „Nie wykryto choroby.”
*	Baza przechowuje informacje o wolontariuszach. Każdy wolontariusz ma indywidualny zakres obowiązków.
 Wolontariusz może mieć przypisane do siebie kilka zwierząt, którymi się opiekuje. Jednak nie każde zwierzę musi mieć swojego wolontariusza.
*	W procesie adopcji bierze udział jeden pracownik, wolontariusz może brać w nim udział, ale nie musi.
*	Wolontariusz nie jest pracownikiem. 
*	Adoptujący może dokonać kilku adopcji. 
*	Tabela „adopcja” zawiera kolumnę „notatki” umożliwiającą wpisanie informacji dotyczących np. warunków mieszkaniowych, innych zwierząt w domu.
*	W numerze budynku dopuszczamy możliwość wystąpienia litery, w numerze mieszkania – nie. 
*	Wagę zwierzęcia podajemy z dokładnością po przecinku.
