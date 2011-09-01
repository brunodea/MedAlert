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
#import "MedNoteViewController.h"
#import "AlarmConfViewController.h"

@implementation ProfileTableViewController

@synthesize mUser;
@synthesize mMedicineArray;
@synthesize mAlarmArray;

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
    self.navigationItem.rightBarButtonItem.title = @"Editar";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [mMedicineArray release];
    [mAlarmArray release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [mMedicineArray release];
    mMedicineArray = [[NSMutableArray alloc] init];
    MedicineDAO *mdao = [[MedicineDAO alloc] init];
    [mMedicineArray addObject:@"add"];
    [mMedicineArray addObjectsFromArray:[mdao medicinesOfUser:mUser.mID]];
    [mdao release];
    
    
    [mAlarmArray release];
    mAlarmArray = [[NSMutableArray alloc] init];
    [mAlarmArray addObject:@"add"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
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
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger res = 0;
    if(section == ALARMS)
        res = [mAlarmArray count];
    else if(section == MEDICINES)
        res = [mMedicineArray count];
    
    return res;
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
        cell.contentMode = UIViewContentModeCenter;
    }
    else
    {
        if(indexPath.section == MEDICINES)
            cell.textLabel.text = [[mMedicineArray objectAtIndex:indexPath.row] mName];
        else if(indexPath.section == ALARMS)
            cell.textLabel.text = @"Alarm Row";//[[mMedicineArray objectAtIndex:indexPath.row] mName];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
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
        case MEDICINES:
            return @"Medicamentos";
        case ALARMS:
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
        if(indexPath.section == MEDICINES)
        {
            MedConfViewController *vc = [[MedConfViewController alloc] init];
            vc.title = @"Adicionar Medicamento";
            vc.mUser = self.mUser;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else if(indexPath.section == ALARMS)
        {
            MedicineDAO *mdao = [[MedicineDAO alloc] init];
            NSArray *arr = [mdao medicinesOfUser:[mUser mID]];
            if([arr count] > 0)
            {
                AlarmConfViewController *vc = [[AlarmConfViewController alloc] init];
                vc.title = @"Alarme Temporizado";
                vc.mMedicinesArray = arr;
                
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }
            else
            {
                UIAlertView *problem = [[UIAlertView alloc] initWithTitle:@"Problema" 
                                                                  message:@"Para você poder criar alarmes, deve ter ao menos um \
                                                                            medicamento cadastrado."
                                                                 delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [problem show];
                [problem release];
            }
            [mdao release];
        }
    }
    else
    {
        if(indexPath.section == MEDICINES)
        {
            MedNoteViewController *vc = [[MedNoteViewController alloc] init];
            vc.title = @"Notas";
            vc.mUser = self.mUser;
            vc.mMedicine = [mMedicineArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
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
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remover";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        if(indexPath.section == MEDICINES)
        {
            ModelMedicine *med = (ModelMedicine *)[mMedicineArray objectAtIndex:indexPath.row];
            MedicineDAO *mdao = [[MedicineDAO alloc] init];
            [mdao removeMedicineByID:[med mID] FromUserByID:[mUser mID]];
            [mdao release];
            
            [mMedicineArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

@end
