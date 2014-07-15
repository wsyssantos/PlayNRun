//
//  PNRPlaylistViewController.m
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRPlaylistViewController.h"
#import "PNRPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PNRPlaylistViewController ()
// Private
@property(nonatomic, strong)NSMutableArray *arrMusicas;
@property(nonatomic, strong)MPMusicPlayerController *musicPlayer;
@property(nonatomic, strong)NSMutableArray *selectedIndex;

// Private Methods
- (void)carregarMusicasIpod;
@end

@implementation PNRPlaylistViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndex = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self carregarMusicasIpod];
}

- (void)carregarMusicasIpod
{
	/* --- Opcoes de musicas a serem recuperadas
	 + (MPMediaQuery *)albumsQuery;
	 + (MPMediaQuery *)artistsQuery;
	 + (MPMediaQuery *)songsQuery;
	 + (MPMediaQuery *)playlistsQuery;
	 + (MPMediaQuery *)podcastsQuery;
	 + (MPMediaQuery *)audiobooksQuery;
	 + (MPMediaQuery *)compilationsQuery;
	 + (MPMediaQuery *)composersQuery;
	 + (MPMediaQuery *)genresQuery;
	 */
	// Monta o array com as musicas do ipod do device
	MPMediaQuery *libMusicas = [MPMediaQuery songsQuery];
	self.arrMusicas = [[NSMutableArray alloc] initWithArray:[libMusicas items]];
    
	// Prepara o music player
	self.musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrMusicas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	MPMediaItem *musicItem = (MPMediaItem *)[_arrMusicas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [musicItem valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [musicItem valueForProperty:MPMediaItemPropertyAlbumArtist];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([self.selectedIndex containsObject:musicItem])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:(204/255) alpha:1];
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.95];
    }
    
    
//    cell.accessoryType = UITableViewCellAccessoryNone;
//	if ([self.currentIndexPath isEqual:indexPath]) {
//		cell.accessoryType = UITableViewCellAccessoryCheckmark;
//	}
    
    [cell setNeedsDisplay];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMediaItem *musicItem = (MPMediaItem *)[_arrMusicas objectAtIndex:indexPath.row];
    
    if ([self.selectedIndex containsObject:musicItem])
    {
        [self.selectedIndex removeObject:musicItem];
    }
    else
    {
        [self.selectedIndex addObject:musicItem];
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PNRPlayerViewController *playerController = segue.destinationViewController;
    playerController.managedObjectContext = self.managedObjectContext;
    playerController.arrMusicas = self.selectedIndex;
}


@end
