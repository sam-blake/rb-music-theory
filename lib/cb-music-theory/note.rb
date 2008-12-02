module CBMusicTheory
  
  class Note < ValuePrimitive
  
    def self.twelve_tones
      ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    end

    def self.flat_twelve_tones
      ["C","Db","D","Eb","E","F","Gb","G","Ab","A","Bb","B"]
    end

    def initialize(var = nil)
      if var.kind_of?(String)
        @value = Note.value_from_name(var)
      else
        @value = var
      end
    end

  
    def self.value_from_name(name)
      #The octave isn't supplied, so 
      #default to octave #4 (see MIDI reference at http://www.harmony-central.com/MIDI/Doc/table2.html)
      result = Note.twelve_tones.index(name) || Note.flat_twelve_tones.index(name)
      result += 60
    end

    def self.name_from_value(v)
      Note.twelve_tones[v % 12]
    end

    def distance_to(other)
      other.value - @value
    end

    def octave
      (@value / 12) - 1
    end
  
    def name
      Note.name_from_value(@value)
    end
    
    def chromatic_scale
       Scale.new(self,NoteInterval.chromatic_set)
     end

     def major_scale
       Scale.new(self,NoteInterval.ionian_set)
     end

     def dorian_scale
       Scale.new(self,NoteInterval.dorian_set)
     end

     def phrygian_scale
       Scale.new(self,NoteInterval.phrygian_set)
     end

     def lydian_scale
       Scale.new(self,NoteInterval.lydian_set)
     end

     def mixolydian_scale
       Scale.new(self,NoteInterval.mixolydian_set)
     end

     def aeolian_scale
       Scale.new(self,NoteInterval.aeolian_set)
     end
     alias natural_minor_scale aeolian_scale

     def locrian_scale
       Scale.new(self,NoteInterval.locrian_set)
     end

     def harmonic_minor_scale
       Scale.new(self,NoteInterval.harmonic_minor_set)
     end

     def melodic_minor_scale
       Scale.new(self,NoteInterval.melodic_minor_set)
     end

     def whole_tone_scale
       Scale.new(self,NoteInterval.whole_tone_set)
     end

     def diminished_scale
       Scale.new(self,NoteInterval.diminished_set)
     end

     def major_pentatonic_scale
       Scale.new(self,NoteInterval.major_pentatonic_set)
     end

     def minor_pentatonic_scale
       Scale.new(self,NoteInterval.minor_pentatonic_set)
     end

     def minor_major_pentatonic_scale
       Scale.new(self,NoteInterval.minor_major_pentatonic_set)
     end
   
     def enigmatic_scale
       Scale.new(self,NoteInterval.enigmatic_set)
     end

     def major_neapolitan_scale
       Scale.new(self,NoteInterval.major_neapolitan_set)
     end

     def minor_neapolitan_scale
       Scale.new(self,NoteInterval.minor_neapolitan_set)
     end

     def minor_hungarian_scale
       Scale.new(self,NoteInterval.minor_hungarian_set)
     end


    def self.chord_methods
      Note.instance_methods.select{|m| m =~ Regexp.new(/chord$/)}
    end
  
    def self.scale_methods
      Note.instance_methods.select{|m| m =~ Regexp.new(/scale$/)}
    end
  
    def self.random_scale_method
      (Note.scale_methods - ["chromatic_scale"]).pick
    end
  
    def self.random_chord_method
      Note.chord_methods.pick
    end

    def self.random_chord_or_scale_method
      [Note.random_chord_method,Note.random_scale_method].pick
    end
  
    def major_chord
      Chord.new(self,SortedSet.new([NoteInterval.unison,NoteInterval.maj3,NoteInterval.per5].to_set))
    end
  
    def minor_chord
      Chord.new(self,[NoteInterval.unison,NoteInterval.min3,NoteInterval.per5])
    end
  
    def dim_chord
      Chord.new(self,[NoteInterval.unison,NoteInterval.min3,NoteInterval.dim5])
    end
  
    def aug_chord
      Chord.new(self,[NoteInterval.unison,NoteInterval.maj3,NoteInterval.sharp5])
    end
      
    def fifth_chord
      Chord.new(self,[NoteInterval.unison,NoteInterval.per5])
    end
    
    def sus2_chord
      fifth_chord.add_interval(NoteInterval.maj2)
    end

    def sus4_chord
      fifth_chord.add_interval(NoteInterval.per4)
    end
  
    def dim7_chord
      dim_chord.add_interval(NoteInterval.bb7)
    end
  
    def half_dim_chord
      dim_chord.add_interval(NoteInterval.b7)
    end
  
    def seventh_chord
      major_chord.add_interval(NoteInterval.b7)
    end
    alias dom7_chord seventh_chord
  
    def min7_chord
      minor_chord.add_interval(NoteInterval.min7)
    end

    def maj7_chord
      major_chord.add_interval(NoteInterval.maj7)
    end
    
    def minmaj7_chord
      minor_chord.add_interval(NoteInterval.maj7)
    end

    def seventh_sus2_chord
      sus2_chord.add_interval(NoteInterval.b7)
    end

    def seventh_sus4_chord
      sus4_chord.add_interval(NoteInterval.b7)
    end
  
    def add2_chord
      major_chord.add_interval(NoteInterval.maj2)
    end
  
    def add9_chord
      major_chord.add_interval(NoteInterval.maj9)
    end
  
    def add4_chord
      major_chord.add_interval(NoteInterval.per4)
    end
  
    def sixth_chord
      major_chord.add_interval(NoteInterval.maj6)
    end
  
    def min6_chord
      minor_chord.add_interval(NoteInterval.maj6)
    end
  
    def six_nine_chord
      sixth_chord.add_interval(NoteInterval.maj9)
    end
  
    def ninth_chord
      seventh_chord.add_interval(NoteInterval.maj9)
    end
  
    def min9_chord
      min7_chord.add_interval(NoteInterval.maj9)
    end
  
    def maj9_chord
      maj7_chord.add_interval(NoteInterval.maj9)
    end
  
    def eleventh_chord
      ninth_chord.add_interval(NoteInterval.maj11)
    end
  
    def min11_chord
      min9_chord.add_interval(NoteInterval.maj11)
    end

    def maj11_chord
      maj9_chord.add_interval(NoteInterval.maj11)
    end

    def thirteenth_chord
      eleventh_chord.add_interval(NoteInterval.maj13)
    end
  
    def min13_chord
      min11_chord.add_interval(NoteInterval.maj13)
    end
  
    def maj13_chord
      maj11_chord.add_interval(NoteInterval.maj13)
    end
  
    def seventh_sharp9_chord
      seventh_chord.add_interval(NoteInterval.sharp9)
    end

    def seventh_b9_chord
      seventh_chord.add_interval(NoteInterval.b9)
    end

    def seventh_sharp5_chord
      seventh_chord.replace_interval(NoteInterval.per5,NoteInterval.sharp5)
    end

    def seventh_b5_chord
      seventh_chord.replace_interval(NoteInterval.per5,NoteInterval.b5)
    end

  end
end