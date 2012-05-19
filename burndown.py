#!/usr/bin/python

import sqlite3 as sqlite
import time
import code
import codecs


class Tickets:
	changes_sql="select c.issue_id,c.attr_id,c.value_new,s.stamp_time from changes c, stamps s where c.stamp_id = s.stamp_id and c.attr_id in (7,13,15) order by s.stamp_time"
	cleanup_sql="delete from states"
	insert_sql="insert into states (issue_id,milestone,status,size,date) values (?,?,?,?,?)"
	statuses_sql="select distinct(value_new) as status from changes where attr_id=7"
	stats = [ u"Closed", u"Processed", u"Active", u"In progress", u"Test case"] 
	def __init__(self,con):
		self.outfile=codecs.open("burndown.dat","w","utf-8")
		self.current = {}
		self.days = {}
		self.today = None
		self.con = con
		self.statuses = []
		self.run()

	def run(self):
		c=self.con.cursor()
		c.execute(self.statuses_sql)
		self.outfile.write("Milestone,date,")
		for r in self.stats:
			self.outfile.write(u"%s,"%r)
			self.statuses.append(r)
		self.outfile.write("\n")
		c.execute(self.cleanup_sql)
		c.execute(self.changes_sql)
		for r in c:
			self.processChange(r)
		c.close()

	def update(self,issue_id,attr_id,value_new,stamp_time):
		day = self.dayOf(stamp_time)
		if self.today != day:
			self.newDay(day)
		ticket = self.getTicketById(issue_id)
		ticket.update(attr_id,value_new)

	def addToSum(self,c,ob):
		if c.has_key(ob.milestone):
			cur = c[ob.milestone]
		else:
			c[ob.milestone]={}
			cur = c[ob.milestone]
			for s in self.statuses:
				cur[s] = 0
		#print ob,cur.keys()
		cur[ob.state] += ob.size

	def newDay(self,day):
		c = {}
		for i in self.current:
			ob = self.current[i]
			self.addToSum(c,ob)
		for mile in c:
			self.outfile.write(u"%s,%s,"%(self.today,mile))
			for s in self.statuses:
				self.outfile.write(u"%s,"%c[mile][s])
			self.outfile.write("\n")
			
		self.today=day

	def getTicketById(self,issue_id):
		if self.current.has_key(issue_id):
			return self.current[issue_id]
		r = Ticket(issue_id)
		self.current[issue_id] = r
		return r

	def processChange(self,change):
		#change is a resultset
		self.update(*change)

	def dayOf(self,unixtime):
		return time.strftime("%Y-%m-%d",time.localtime(unixtime))
		

class Ticket:

	shirttable = {'XS':1,'S':2, 'M':4, 'L':8, 'XL': 16}

	def __init__(self, issue_id):
		self.size=4
		self.issue_id=issue_id
		self.state='Active'
		self.milestone="Feladatok"

	def shirtToSize(self,shirt):
		if self.shirttable.has_key(shirt):
			return self.shirttable[shirt]
		return self.shirttable['M']

	def update(self,attr_id,value):
		if attr_id == 13:
			#shirt
			self.size=self.shirtToSize(value)
		elif attr_id == 7:
			#state
			self.state = value
		elif attr_id == 15:
			#milestone
			self.milestone = value
		else:
			pass

	def __repr__(self):
		return u"%s,%s,%s,%s"%(self.issue_id,self.milestone,self.state,self.size)

con = sqlite.connect("wi.db")

t = Tickets(con)
con.close()
