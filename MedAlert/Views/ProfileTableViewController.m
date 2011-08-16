//
//  ProfileTableViewController.m
//  MedAlert
//
//  Created by Bruno Romero de Azevedo on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "MedicineDAO.h"
#import "MedConfViewController.h"

@implementation ProfileTableViewController

@synthesize mUser;
@synthesize mMedicineArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    mMedicineArray = [[NSMutableArray alloc] initWithArray:[mdao medicinesOfUser:mUser.mID]];
    
    [mMedicineArray addObject:@"add"];
    
    [mdao release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [mMedicineArray release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [mMedicineArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"Adicionar";
        cell.accessoryType = UITableViewCellEditingStyleInsert;
    }
    else
        cell.textLabel.text = [[mMedicineArray objectAtIndex:indexPath.row] mName];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return NO;
    
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) 
    {
        case 0:
            return @"Medicamentos";
        case 1:
            return @"Alarmes";
        default:
            NSLog(@"Erro ao ajustar titulo de uma section.");
            break;
    }
    return @"Erro";
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UIViewController *vc = nil;
        switch(indexPath.section)
        {
            case 0:
                vc = [[MedConfViewController alloc] init];
                vc.title = @"Adicionar Medicamento";
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                break;
            case 1:
                break;
            default:
                break;
        }
    }
    
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return NO;
    
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
//        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
