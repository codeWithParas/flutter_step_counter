

void main(){

  var notes = {1,2,3,4, 'Note1', 'Note3'};

  List<Note> noteListMemory = [
    Note("ABCD", "sdfsdf", "5th July"),
    Note("ABCcsdcD", "sdfsdf", "5th July"),
    Note("ABCcdcD", "sdfsdf", "5th July"),
    Note("ABcdCD", "sdfsdf", "5th July"),
    Note("ABCzxD", "sdfsdf", "5th July"),
    Note("ABCDv", "sdfsdf", "5th July"),
    Note("ABCdfD", "sdfsdf", "5th July"),
    Note("ABCzsD", "sdfsdf", "5th July"),
    Note("ABsCD", "sdfsdf", "5th July"),
    Note("AB23CD", "sdfsdf", "5th July"),
    Note("ABC4ccD", "sdfsdf", "5th July"),
    Note("ABC432D", "sdfsdf", "5th July"),
    Note("AB65D", "sdfsdf", "5th July"),
    Note("ABC676D", "sdfsdf", "5th July"),
    Note("ABC767D", "sdfsdf", "5th July"),
    Note("ABC445D", "sdfsdf", "5th July"),
    Note("AB3434CD", "sdfsdf", "5th July"),
    Note("234", "sdfsdf", "5th July"),
    Note("ABC76D", "sdfsdf", "5th July"),
    Note("AB676CD", "sdfsdf", "5th July"),
    Note("AB454CD", "sdfsdf", "5th July"),
    Note("43343", "sdfsdf", "5th July"),
    Note("AB232CD", "sdfsdf", "5th July"),
  ];

  // UI Layer
  for(var n in noteListMemory){
    print(n.title);
  }
}

class Note
{
  var _title;
  var _description;
  var _date;

  // Constructor
  Note(this._title, this._description, this._date);

  set title(String newTitle){
    this._title = newTitle;
  }
  String get title => _title;

  set description(String newDesc){
    this._description = newDesc;
  }
  String get description => _description;

  set date(String newDate){
    this._date = newDate;
  }
  String get date => _date;
}