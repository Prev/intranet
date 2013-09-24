<?php 

/**
 * A simple class to read variable byte length binary data. 
 * This is basically is a better replacement for unpack() function
 * which creates a very large associative array.
 *
 * @author Shubham Jain <shubham.jain.1@gmail.com> 
 * @example https://github.com/shubhamjain/PHP-ID3
 * @license MIT License
 */

class BinaryFileReader {
	const SIZE_OF = 1; 		   //size of block depends upon the variable defined in the next array element.
	const NULL_TERMINATED = 2; //Block is read until NULL is encountered.
	const EOF_TERMINATED = 3;  //Block is read until EOF  is encountered.
	const FIXED = 4;  	   	   //Block size is fixed.

	const INT = 5;  	//Datatypes to transform the read block
	const FLOAT = 6;
	
	private $_fp; //file handle to read data
	private $_map; //Associative array of Varaibles and their info ( TYPE, SIZE, DATA_TYPE)
				  // In special cases it can be an array to handle different
				  // Types of block data lengths

	public function __construct ( $fp, array $map )
	{
		$this->_fp = $fp;
		$this->SetMap( $map );
		
	}

	public function SetMap ( $map ) 
	{
		$this->_map = $map;

		foreach ($map as $key => $size) {
			$this->$key = NULL; //Create variables from keys of $map
		}
	}

	public function Read() 
	{	
		if( feof($this->_fp) )
			return false;

		foreach ($this->_map as $key => $info) 
		{		
				switch ( $info[0] ) 
				{					
					case self::NULL_TERMINATED:			
						while( (int)bin2hex(($ch = fgetc( $this->_fp ))) !== 0 ) 
							$this->$key .= $ch;	break;
						
					case self::EOF_TERMINATED:		
						while( !feof($this->_fp) ) 
							$this->$key .= fgetc( $this->_fp );	break;

					case self::SIZE_OF:					
						if( !( $info[1] = $this->$info[1] )) //If the variable is not an integer retunn false
							return false;

					default:

						$this->$key = fread($this->_fp, $info[1]); //Read as string					
					
				}

				if( isset($info[2]) )
					switch ( $info[2] )
					{
						case self::INT:
							$this->$key = intval(bin2hex($this->$key), 16); break;
						case self::FLOAT:
							$this->$key = floatval(bin2hex($this->$key), 16);
					} 
		}

		return $this;
	}

}


/**
 * Read ID3Tags and thumbnails.
 *
 * @author Shubham Jain <shubham.jain.1@gmail.com> 
 * @license MIT License
 */


Class ID3TagsReader {

	private $_FileReader;
	private $_ID3Array;

	public $ID3Tags = array(
		'AENC' =>  'Audio encryption',
		'APIC' =>  'Attached picture',
		'COMM' =>  'Comments',
		'COMR' =>  'Commercial frame',
		'ENCR' =>  'Encryption method registration',
		'EQUA' =>  'Equalization',
		'ETCO' =>  'Event timing codes',
		'GEOB' =>  'General encapsulated object',
		'GRID' =>  'Group identification registration',
		'IPLS' =>  'Involved people list',
		'LINK' =>  'Linked information',
		'MCDI' =>  'Music CD identifier',
		'MLLT' =>  'MPEG location lookup table',
		'OWNE' =>  'Ownership frame',
		'PRIV' =>  'Private frame',
		'PCNT' =>  'Play counter',
		'POPM' =>  'Popularimeter',
		'POSS' =>  'Position synchronisation frame',
		'RBUF' =>  'Recommended buffer size',
		'RVAD' =>  'Relative volume adjustment',
		'RVRB' =>  'Reverb',
		'SYLT' =>  'Synchronized lyric/text',
		'SYTC' =>  'Synchronized tempo codes',
		'TALB' =>  'Album/Movie/Show title',
		'TBPM' =>  'BPM (beats per minute)',
		'TCOM' =>  'Composer',
		'TCON' =>  'Content type',
		'TCOP' =>  'Copyright message',
		'TDAT' =>  'Date',
		'TDLY' =>  'Playlist delay',
		'TENC' =>  'Encoded by',
		'TEXT' =>  'Lyricist/Text writer',
		'TFLT' =>  'File type',
		'TIME' =>  'Time',
		'TIT1' =>  'Content group description',
		'TIT2' =>  'Title/songname/content description',
		'TIT3' =>  'Subtitle/Description refinement',
		'TKEY' =>  'Initial key',
		'TLAN' =>  'Language(s)',
		'TLEN' =>  'Length',
		'TMED' =>  'Media type',
		'TOAL' =>  'Original album/movie/show title',
		'TOFN' =>  'Original filename',
		'TOLY' =>  'Original lyricist(s)/text writer(s)',
		'TOPE' =>  'Original artist(s)/performer(s)',
		'TORY' =>  'Original release year',
		'TOWN' =>  'File owner/licensee',
		'TPE1' =>  'Lead performer(s)/Soloist(s)',
		'TPE2' =>  'Band/orchestra/accompaniment',
		'TPE3' =>  'Conductor/performer refinement',
		'TPE4' =>  'Interpreted, remixed, or otherwise modified by',
		'TPOS' =>  'Part of a set',
		'TPUB' =>  'Publisher',
		'TRCK' =>  'Track number/Position in set',
		'TRDA' =>  'Recording dates',
		'TRSN' =>  'Internet radio station name',
		'TRSO' =>  'Internet radio station owner',
		'TSIZ' =>  'Size',
		'TSRC' =>  'ISRC (international standard recording code)',
		'TSSE' =>  'Software/Hardware and settings used for encoding',
		'TYER' =>  'Year',
		'TXXX' =>  'User defined text information frame',
		'UFID' =>  'Unique file identifier',
		'USER' =>  'Terms of use',
		'USLT' =>  'Unsychronized lyric/text transcription',
		'WCOM' =>  'Commercial information',
		'WCOP' =>  'Copyright/Legal information',
		'WOAF' =>  'Official audio file webpage',
		'WOAR' =>  'Official artist/performer webpage',
		'WOAS' =>  'Official audio source webpage',
		'WORS' =>  'Official internet radio station homepage',
		'WPAY' =>  'Payment',
		'WPUB' =>  'Publishers official webpage',
		'WXXX' =>  'User defined URL link frame',
	);

	public function __construct( $FileHandle )
	{
		$this->_FileReader = new BinaryFileReader($FileHandle, array(
			"ID3" => array(BinaryFileReader::FIXED, 3),
			"Version" => array(BinaryFileReader::FIXED, 2),
			"Flag" => array(BinaryFileReader::FIXED, 1),
			"SizeTag" => array(BinaryFileReader::FIXED, 4, BinaryFileReader::INT),
		));		

		$this->_FileReader->Read();
	}

	public function ReadAllTags() {
		
		$bytesPos = 10; //From headers

		$this->_FileReader->SetMap( array(
			"FrameID" => array(BinaryFileReader::FIXED, 4),
			"Size" => array(BinaryFileReader::FIXED, 4, BinaryFileReader::INT),
			"Flag" => array(BinaryFileReader::FIXED, 2),
			"Body" => array(BinaryFileReader::SIZE_OF, "Size"),
		));

		while( ($file_data = $this->_FileReader->Read()) )
		{
			if( ! in_array( $file_data->FrameID, array_keys($this->ID3Tags) ) )
				break;
			
			$this->_ID3Array[ $file_data->FrameID ] = array(
					 "FullTagName" => $this->ID3Tags[  $file_data->FrameID ],
					 "Position" => $bytesPos,
					 "Size" => $file_data->Size,
					 "Body" => $file_data->Body,
				);

			$bytesPos += 4 + 4 + 2 + $file_data->Size;		
		}

		return $this;
	}

	public function GetID3Array() {
		return $this->_ID3Array;
	}

	public function GetImage() {
		$fp = fopen('data://text/plain;base64,'.base64_encode($this->_ID3Array["APIC"]["Body"]), 'rb'); //Create an artificial stream from Image data

		$fileReader = new BinaryFileReader( $fp, array(
			"TextEncoding" => array(BinaryFileReader::FIXED, 1),
			"MimeType" => array(BinaryFileReader::NULL_TERMINATED),
			"FileName" => array(BinaryFileReader::NULL_TERMINATED),
			"ContentDesc" => array(BinaryFileReader::NULL_TERMINATED),
			"BinaryData" => array(BinaryFileReader::EOF_TERMINATED)) );

		
		$imageData = $fileReader->Read();

		return array( $imageData->MimeType, $imageData->BinaryData );
	}
}

