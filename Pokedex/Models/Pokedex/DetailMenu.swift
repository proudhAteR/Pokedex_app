//
//  Menu.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-25.
//

import Foundation

enum DetailMenu : String, Identifiable, CaseIterable{
	case About, Stats,Upgrades
	var id : Self{self}
}
